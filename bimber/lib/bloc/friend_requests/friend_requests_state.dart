part of 'friend_requests_bloc.dart';

abstract class FriendRequestsResources{
  List<User> getRequests();
}

@immutable
abstract class FriendRequestsState extends Equatable {
  const FriendRequestsState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class FriendRequestsInitial extends FriendRequestsState {}

class FriendRequestsError extends FriendRequestsState {
  final String message;

  FriendRequestsError({@required this.message});

  @override
  List<Object> get props => [message];
}

class FriendRequestsFetched extends FriendRequestsState implements FriendRequestsResources{
  final List<User> requests;

  FriendRequestsFetched({@required this.requests});

  @override
  List<Object> get props => [requests];

  @override
  List<User> getRequests() {
   return requests;
  }
}

class FriendRequestsLoading extends FriendRequestsState implements FriendRequestsResources{
  final List<User> requests;

  FriendRequestsLoading({@required this.requests});

  @override
  List<Object> get props => [requests];

  @override
  List<User> getRequests() {
    return requests;
  }

}

class FriendRequestsCancelSuccess extends FriendRequestsState implements FriendRequestsResources{
  final List<User> requests;

  FriendRequestsCancelSuccess({@required this.requests});

  @override
  List<Object> get props => [requests];

  @override
  List<User> getRequests() {
    return requests;
  }

}

class FriendRequestsCancelError extends FriendRequestsState implements FriendRequestsResources{
  final List<User> requests;

  FriendRequestsCancelError({@required this.requests});

  @override
  List<Object> get props => [requests];

  @override
  List<User> getRequests() {
    return requests;
  }
}

class FriendRequestsAcceptSuccess extends FriendRequestsState implements FriendRequestsResources{
  final List<User> requests;

  FriendRequestsAcceptSuccess({@required this.requests});

  @override
  List<Object> get props => [requests];

  @override
  List<User> getRequests() {
  return requests;
  }
}

class FriendRequestsAcceptError extends FriendRequestsState implements FriendRequestsResources{
  final List<User> requests;

  FriendRequestsAcceptError({@required this.requests});

  @override
  List<Object> get props => [requests];

  @override
  List<User> getRequests() {
    return requests;
  }
}

