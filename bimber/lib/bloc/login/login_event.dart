part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class LoginCheckEmail extends LoginEvent {
  final String email;
  LoginCheckEmail({@required this.email});

  @override
  List<Object> get props => [email];
}

class LoginCheckPassword extends LoginEvent {
  final String email;
  final String password;
  LoginCheckPassword({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginReset extends LoginEvent {}
