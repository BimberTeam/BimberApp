part of 'group_requests_bloc.dart';

@immutable
abstract class GroupRequestState extends Equatable {
  const GroupRequestState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class GroupRequestsInitial extends GroupRequestState {}

class GroupRequestsError extends GroupRequestState {
  final String message;

  GroupRequestsError({@required this.message});

  @override
  List<Object> get props => [message];
}

class GroupRequestResources extends GroupRequestState {
  final List<Group> requests;

  GroupRequestResources({@required this.requests});

  @override
  List<Object> get props => [requests];

  List<Group> getGroupRequests() {
    return requests;
  }
}

class GroupRequestsFetched extends GroupRequestResources {
  GroupRequestsFetched({@required requests}) : super(requests: requests);
}

class GroupRequestsLoading extends GroupRequestResources {
  GroupRequestsLoading({@required requests}) : super(requests: requests);
}

class GroupRequestDeclineSuccess extends GroupRequestResources {
  GroupRequestDeclineSuccess({@required requests}) : super(requests: requests);
}

class GroupRequestDeclineError extends GroupRequestResources {
  GroupRequestDeclineError({@required requests}) : super(requests: requests);
}

class GroupRequestAcceptSuccess extends GroupRequestResources {
  GroupRequestAcceptSuccess({@required requests}) : super(requests: requests);
}

class GroupRequestAcceptError extends GroupRequestResources {
  GroupRequestAcceptError({@required requests}) : super(requests: requests);
}
