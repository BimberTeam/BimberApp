import 'dart:async';
import 'package:bimber/resources/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part "authentication_event.dart";
part "authentication_state.dart";

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AccountRepository _accountRepository;
  AuthenticationBloc({@required AccountRepository accountRepository})
      : _accountRepository = accountRepository,
        super(Uninitialized());

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
      yield ServerNotResponding();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isLoggedIn = await _accountRepository.isLoggedIn();
      yield (isLoggedIn ? Authenticated() : Unauthenticated());
    } catch (e) {
      yield (e is TimeoutException ? ServerNotResponding() : Unauthenticated());
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    try {
      yield Authenticated();
    } catch (e) {
      yield (e is TimeoutException ? ServerNotResponding() : Unauthenticated());
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await _accountRepository.logout();
    yield Unauthenticated();
  }
}
