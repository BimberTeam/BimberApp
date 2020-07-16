import 'dart:async';
import 'package:bimber/bloc/login/login.dart';
import 'package:bimber/resources/account_repository.dart';
import 'package:bloc/bloc.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final AccountRepository _accountRepository;
  LoginBloc(this._accountRepository) : super(null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginCheckEmail) {
      yield* _mapCheckEmailToState(event);
    } else if (event is LoginCheckPassword) {
      yield* _mapCheckPasswordToState(event);
    } else if (event is LoginReset){
      yield LoginInitial();
    }
  }

  Stream<LoginState> _mapCheckEmailToState(LoginCheckEmail event) async*{
      yield LoginLoading();
      try{
        bool emailExists = await _accountRepository.checkIfEmailExists(event.email).timeout(Duration(seconds: 5));
        if(emailExists){
          yield LoginEmailExists(event.email);
        } else{
          yield LoginEmailNotExists(event.email);
        }
      } catch( exception){
        if(exception is TimeoutException) yield LoginServerNotResponding();
        else yield LoginFailed();
      }
  }

  Stream<LoginState> _mapCheckPasswordToState(LoginCheckPassword event) async*{
      yield LoginLoading();
      try{
        bool loginSucceed = await _accountRepository.login(event.email, event.password).timeout(Duration(seconds: 5));
        if(loginSucceed){
          yield LoginSucceed();
        } else{
          yield LoginFailed();
        }
      } catch( exception){
        if(exception is TimeoutException) yield LoginServerNotResponding();
        else yield LoginFailed();
      }
    }
}