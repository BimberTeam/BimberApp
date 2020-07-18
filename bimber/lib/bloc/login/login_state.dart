import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{
  const LoginState();
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class LoginInitial extends LoginState{}

class LoginLoading extends LoginState{}

class LoginEmailExists extends LoginState{
  final String email;
  LoginEmailExists(this.email);

  @override
  List<Object> get props => [email];
}

class LoginEmailNotExists extends LoginState{
  final String email;
  LoginEmailNotExists(this.email);

  @override
  List<Object> get props => [email];
}

class LoginSucceed extends LoginState{}

class LoginFailed extends LoginState{}

class LoginServerNotResponding extends LoginState{}