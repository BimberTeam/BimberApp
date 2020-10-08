part of 'group_requests_bloc.dart';

@immutable
abstract class GroupRequestsEvent extends Equatable {
  const GroupRequestsEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitGroupRequests extends GroupRequestsEvent {}

class RefreshGroupRequests extends GroupRequestsEvent {}

class CancelGroupInvitation extends GroupRequestsEvent {
  final String groupId;

  CancelGroupInvitation({@required this.groupId});

  @override
  List<Object> get props => [groupId];
}

class AcceptGroupInvitation extends GroupRequestsEvent {
  final String groupId;

  AcceptGroupInvitation({@required this.groupId});

  @override
  List<Object> get props => [groupId];
}