part of 'group_requests_bloc.dart';

abstract class GroupRequestsResources{
  List<Group> getGroupRequests();
}

@immutable
abstract class GroupRequestsState extends Equatable {
  const GroupRequestsState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class GroupRequestsInitial extends GroupRequestsState {}

class GroupRequestsError extends GroupRequestsState {
  final String message;

  GroupRequestsError({@required this.message});

  @override
  List<Object> get props => [message];
}

class GroupRequestsFetched extends GroupRequestsState implements GroupRequestsResources{
  final List<Group> requests;

  GroupRequestsFetched({@required this.requests});

  @override
  List<Object> get props => [requests];

  @override
  List<Group> getGroupRequests() {
    return requests;
  }
}

class GroupRequestsLoading extends GroupRequestsState implements GroupRequestsResources{
  final List<Group> requests;

  GroupRequestsLoading({@required this.requests});

  @override
  List<Object> get props => [requests];

  @override
  List<Group> getGroupRequests() {
    return requests;
  }

}

class GroupRequestsCancelSuccess extends GroupRequestsState implements GroupRequestsResources{
  final List<Group> requests;

  GroupRequestsCancelSuccess({@required this.requests});

  @override
  List<Object> get props => [requests];

  @override
  List<Group> getGroupRequests() {
    return requests;
  }

}

class GroupRequestsCancelError extends GroupRequestsState implements GroupRequestsResources{
  final List<Group> requests;

  GroupRequestsCancelError({@required this.requests});

  @override
  List<Object> get props => [requests];

  @override
  List<Group> getGroupRequests() {
    return requests;
  }
}

class GroupRequestsAcceptSuccess extends GroupRequestsState implements GroupRequestsResources{
  final List<Group> requests;

  GroupRequestsAcceptSuccess({@required this.requests});

  @override
  List<Object> get props => [requests];

  @override
  List<Group> getGroupRequests() {
    return requests;
  }
}

class GroupRequestsAcceptError extends GroupRequestsState implements GroupRequestsResources{
  final List<Group> requests;

  GroupRequestsAcceptError({@required this.requests});

  @override
  List<Object> get props => [requests];

  @override
  List<Group> getGroupRequests() {
    return requests;
  }
}

