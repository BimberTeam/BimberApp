import 'dart:async';
import 'package:bimber/resources/graphql_repositories/common.dart';
import 'package:bimber/resources/repositories/account_repository.dart';
import 'package:bimber/resources/services/token_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part "authentication_event.dart";
part "authentication_state.dart";

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AccountRepository accountRepository;
  AuthenticationBloc({@required this.accountRepository})
      : super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    } else if (event is ServerTimeout) {
      yield AuthServerNotResponding();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isLoggedIn = await accountRepository.isLoggedIn();
      yield (isLoggedIn ? Authenticated() : Unauthenticated());
    } catch (e) {
      yield (e is GraphqlConnectionError
          ? AuthServerNotResponding()
          : Unauthenticated());
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    try {
      yield Authenticated();
    } catch (e) {
      await TokenService.deleteToken();
      yield (e is GraphqlConnectionError
          ? AuthServerNotResponding()
          : Unauthenticated());
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await accountRepository.logout();
    yield Unauthenticated();
  }
}
