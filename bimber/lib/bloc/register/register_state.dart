part of 'register_bloc.dart';

@immutable
abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class RegisterInitial extends RegisterState {}

class RegisterError extends RegisterState {
  final String message;

  RegisterError({@required this.message});

  @override
  List<Object> get props => [message];
}

class RegisterSuccess extends RegisterState {}
