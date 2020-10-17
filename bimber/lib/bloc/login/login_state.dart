part of "login_bloc.dart";

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginEmailExists extends LoginState {
  final String email;
  LoginEmailExists({@required this.email});

  @override
  List<Object> get props => [email];
}

class LoginEmailNotExists extends LoginState {
  final String email;
  LoginEmailNotExists({@required this.email});

  @override
  List<Object> get props => [email];
}

class LoginSucceed extends LoginState {}

class LoginFailed extends LoginState {
  final String message;

  LoginFailed({@required this.message});
}

class LoginServerNotResponding extends LoginState {}
