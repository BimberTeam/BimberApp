import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginCheckEmail extends LoginEvent{
  final String email;
  LoginCheckEmail(this.email);

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'LoginCheckEmail { email: $email}';
  }
}

class LoginCheckPassword extends LoginEvent{
  final String email;
  final String password;
  LoginCheckPassword(this.email, this.password);

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'LoginCheckPassword { email: $email, password: $password}';
  }

}