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

class AddFriendsResources extends AddFriendsState {
  final List<User> possibleMembers;

  AddFriendsResources({@required this.possibleMembers});

  @override
  List<Object> get props => [possibleMembers];

  List<User> getPossibleMembers() {
    return possibleMembers;
  }
}

class AddFriendsFetched extends AddFriendsResources {
  AddFriendsFetched({@required possibleMembers})
      : super(possibleMembers: possibleMembers);
}

class AddFriendsLoading extends AddFriendsResources {
  AddFriendsLoading({@required possibleMembers})
      : super(possibleMembers: possibleMembers);
}

class AddFriendsSuccess extends AddFriendsResources {
  AddFriendsSuccess({@required possibleMembers})
      : super(possibleMembers: possibleMembers);
}

class AddFriendsFailure extends AddFriendsResources {
  AddFriendsFailure({@required possibleMembers})
      : super(possibleMembers: possibleMembers);
}
