part of "authentication_bloc.dart";

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {}

class AuthServerNotResponding extends AuthenticationState {}
