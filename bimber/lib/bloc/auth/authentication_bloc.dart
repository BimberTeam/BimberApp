import 'dart:async';
import 'package:bimber/resources/graphql_repositories/common.dart';
import 'package:bimber/resources/repositories/account_repository.dart';
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
      Future<bool> isLoggedIn = accountRepository.isLoggedIn();
      await Future.delayed(Duration(milliseconds: 4500));
      if (await isLoggedIn) {
        accountRepository.updateLocation();
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    } catch (e) {
      if (e is TimeoutException || e is GraphqlConnectionError)
        yield AuthServerNotResponding();
      else
        Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    accountRepository.updateLocation();
    yield Authenticated();
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await accountRepository.logout();
    yield Unauthenticated();
  }
}
