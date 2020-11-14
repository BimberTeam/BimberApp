part of 'add_friend_bloc.dart';

@immutable
abstract class AddFriendsState extends Equatable {
  const AddFriendsState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class AddFriendsInitial extends AddFriendsState {}

class AddFriendsError extends AddFriendsState {
  final String message;

  AddFriendsError({@required this.message});

  @override
  List<Object> get props => [message];
}

class AddFriendsFetched extends AddFriendsState {
  final List<User> possibleMembers;

  AddFriendsFetched({@required this.possibleMembers});

  @override
  List<Object> get props => [possibleMembers];
}

class AddFriendsLoading extends AddFriendsState {}

class AddFriendsSuccess extends AddFriendsState {}

class AddFriendsFailure extends AddFriendsState {
  final String message;

  AddFriendsFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
