part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class FetchAccount extends AccountEvent {
  final bool useCache;

  @override
  List<Object> get props => super.props..add(useCache);
  FetchAccount({bool useCache = false}) : useCache = useCache;
}

class EditAccount extends AccountEvent {
  final EditAccountData data;
  final int version;

  @override
  List<Object> get props => super.props..addAll([data, version]);

  EditAccount({@required this.data, @required this.version});
}
