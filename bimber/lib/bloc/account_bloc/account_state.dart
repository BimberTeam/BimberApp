part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountError extends AccountState {
  final String message;

  AccountError({@required this.message});
}

class AccountServerNotResponding extends AccountState {}

class AccountFetched extends AccountState {
  final AccountData account;

  @override
  List<Object> get props => [account];

  AccountFetched({@required this.account});
}

// Account edditing states
class EditAccountLoading extends AccountState {}

class EditAccountSuccess extends AccountState {}

class EditAccountError extends AccountState {
  final String message;

  EditAccountError({@required this.message});
}

class AccountDeleted extends AccountState {}
