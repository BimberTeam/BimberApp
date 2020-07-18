import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable{
  const AuthenticationEvent();
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}

class ServerTimeout extends AuthenticationEvent{}