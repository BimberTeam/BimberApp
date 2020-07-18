part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class RegisterAccount extends RegisterEvent {
  final RegisterAccountData data;

  RegisterAccount({@required this.data});

  @override
  List<Object> get props => [data];
}
