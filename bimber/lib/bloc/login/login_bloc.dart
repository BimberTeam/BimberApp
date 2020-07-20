import 'dart:async';
import 'package:bimber/resources/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AccountRepository _accountRepository;
  LoginBloc(this._accountRepository) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginCheckEmail) {
      yield* _mapCheckEmailToState(event);
    } else if (event is LoginCheckPassword) {
      yield* _mapCheckPasswordToState(event);
    } else if (event is LoginReset) {
      yield LoginInitial();
    }
  }

  Stream<LoginState> _mapCheckEmailToState(LoginCheckEmail event) async* {
    yield LoginLoading();
    try {
      bool emailExists =
          await _accountRepository.checkIfEmailExists(event.email);

      yield (emailExists
          ? LoginEmailExists(email: event.email)
          : LoginEmailNotExists(email: event.email));
    } catch (exception) {
      yield (exception is TimeoutException
          ? LoginServerNotResponding()
          : LoginFailed());
    }
  }

  Stream<LoginState> _mapCheckPasswordToState(LoginCheckPassword event) async* {
    yield LoginLoading();
    try {
      bool loginSucceed =
          await _accountRepository.login(event.email, event.password);

      yield (loginSucceed ? LoginSucceed() : LoginFailed());
    } catch (exception) {
      yield (exception is TimeoutException
          ? LoginServerNotResponding()
          : LoginFailed());
    }
  }
}
