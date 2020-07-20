import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable{
  const AuthenticationState();
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class Uninitialized extends AuthenticationState{}

class Authenticated extends AuthenticationState{}

class Unauthenticated extends AuthenticationState {}

class ServerNotResponding extends AuthenticationState{}