part of 'friend_requests_bloc.dart';

@immutable
abstract class FriendRequestsEvent extends Equatable {
  const FriendRequestsEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitFriendRequests extends FriendRequestsEvent {}

class RefreshFriendRequests extends FriendRequestsEvent {}

class CancelFriend extends FriendRequestsEvent {
  final String friendId;

  CancelFriend({@required this.friendId});

  @override
  List<Object> get props => [friendId];
}

class AcceptFriend extends FriendRequestsEvent {
  final String friendId;

  AcceptFriend({@required this.friendId});

  @override
  List<Object> get props => [friendId];
}