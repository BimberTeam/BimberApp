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

class RefetchGroupRequests extends GroupRequestsEvent {}

class DeclineGroupRequest extends GroupRequestsEvent {
  final String groupId;

  DeclineGroupRequest({@required this.groupId});

  @override
  List<Object> get props => [groupId];
}

class AcceptGroupRequest extends GroupRequestsEvent {
  final String groupId;

  AcceptGroupRequest({@required this.groupId});

  @override
  List<Object> get props => [groupId];
}
