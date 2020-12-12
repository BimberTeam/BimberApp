import 'dart:async';
import 'package:bimber/resources/graphql_repositories/common.dart';
import 'package:bimber/resources/repositories/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AccountRepository accountRepository;
  LoginBloc({@required this.accountRepository}) : super(LoginInitial());

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
          await accountRepository.checkIfEmailExists(event.email);

      yield (emailExists
          ? LoginEmailExists(email: event.email)
          : LoginEmailNotExists(email: event.email));
    } catch (exception) {
      yield (exception is GraphqlConnectionError
          ? LoginServerNotResponding()
          : LoginFailed(message: "Nieznany błąd!"));
    }
  }

  Stream<LoginState> _mapCheckPasswordToState(LoginCheckPassword event) async* {
    yield LoginLoading();
    try {
      await accountRepository.login(event.email, event.password);

      yield LoginSucceed();
    } catch (e) {
      if (e is TimeoutException || e is GraphqlConnectionError)
        yield LoginServerNotResponding();
      else
        yield LoginFailed(message: "Nieprawidłowe hasło!");
    }
  }
}
