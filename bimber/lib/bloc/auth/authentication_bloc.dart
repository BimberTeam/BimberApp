import 'dart:async';
import 'package:bimber/bloc/auth/authentication.dart';
import 'package:bimber/resources/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
      final isLoggedIn =
          await _accountRepository.isLoggedIn().timeout(Duration(seconds: 5));
      if (isLoggedIn) {
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    } catch (e) {
      if (e is TimeoutException)
        yield ServerNotResponding();
      else {
        yield Unauthenticated();
      }
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    try {
      yield Authenticated();
    } catch (e) {
      if (e is TimeoutException)
        yield ServerNotResponding();
      else
        yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await _accountRepository.logout();
    yield Unauthenticated();
  }
}
