part of 'friend_requests_bloc.dart';

@immutable
abstract class FriendRequestEvent extends Equatable {
  const FriendRequestEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitFriendRequests extends FriendRequestEvent {}

class RefetchFriendRequests extends FriendRequestEvent {}

class DeclineFriendRequest extends FriendRequestEvent {
  final String friendId;

  DeclineFriendRequest({@required this.friendId});

  @override
  List<Object> get props => [friendId];
}

class AcceptFriendRequest extends FriendRequestEvent {
  final String friendId;

  AcceptFriendRequest({@required this.friendId});

  @override
  List<Object> get props => [friendId];
}