part of 'friend_requests_bloc.dart';

@immutable
abstract class FriendRequestState extends Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class FriendRequestsInitial extends FriendRequestState {}

class FriendRequestsError extends FriendRequestState {
  final String message;

  FriendRequestsError({@required this.message});

  @override
  List<Object> get props => [message];
}

class FriendRequestResources extends FriendRequestState{
  final List<User> requests;

  FriendRequestResources({@required this.requests});

  @override
  List<Object> get props => [requests];

  List<User> getFriendRequests(){
    return this.requests;
  }
}


class FriendRequestsFetched extends FriendRequestResources{
  FriendRequestsFetched({@required requests}) : super(requests: requests);
}

class FriendRequestsLoading extends FriendRequestResources{
  FriendRequestsLoading({@required requests}) : super(requests: requests);
}

class FriendRequestsDeclineSuccess extends FriendRequestResources{
  FriendRequestsDeclineSuccess({@required requests}) : super(requests: requests);
}

class FriendRequestsDeclineError extends FriendRequestResources{
  FriendRequestsDeclineError({@required requests}) : super(requests: requests);
}

class FriendRequestsAcceptSuccess extends FriendRequestResources{
  FriendRequestsAcceptSuccess({@required requests}) : super(requests: requests);
}

class FriendRequestsAcceptError extends FriendRequestResources{
  FriendRequestsAcceptError({@required requests}) : super(requests: requests);
}

