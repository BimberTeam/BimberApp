part of 'register_bloc.dart';

@immutable
abstract class RegisterState extends Equatable {
  const RegisterState();

  RegisterAccountData get data;

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class RegisterInitial extends RegisterState {
  RegisterAccountData get data => null;
}

class RegisterError extends RegisterState {
  final String message;
  final RegisterAccountData data;

  RegisterError({@required this.message, @required this.data});

  @override
  List<Object> get props => [message, data];
}

class RegisterEmailTaken extends RegisterState {
  final RegisterAccountData data;

  RegisterEmailTaken({@required this.data});

  @override
  List<Object> get props => [data];
}

class RegisterSavedData extends RegisterState {
  final RegisterAccountData data;

  RegisterSavedData({@required this.data});

  @override
  List<Object> get props => [data];
}

// TODO: just for tests, no need for data property when registering works
class RegisterSuccess extends RegisterState {
  final RegisterAccountData data;

  RegisterSuccess({@required this.data});

  @override
  List<Object> get props => [data];
}
