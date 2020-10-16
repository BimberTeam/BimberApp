part of 'group_maker_bloc.dart';

@immutable
abstract class GroupMakerState extends Equatable {
  const GroupMakerState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class GroupMakerInitial extends GroupMakerState {}

class GroupMakerError extends GroupMakerState {
  final String message;

  GroupMakerError({@required this.message});

  @override
  List<Object> get props => [message];
}

class GroupMakerResources extends GroupMakerState {
  final List<User> friends;

  GroupMakerResources({@required this.friends});

  @override
  List<Object> get props => [friends];

  List<User> getFriends() {
    return friends;
  }
}

class GroupMakerFetched extends GroupMakerResources {
  GroupMakerFetched({@required friends}) : super(friends: friends);
}

class GroupMakerLoading extends GroupMakerResources {
  GroupMakerLoading({@required friends}) : super(friends: friends);
}

class GroupMakerSuccess extends GroupMakerResources {
  GroupMakerSuccess({@required friends}) : super(friends: friends);
}

class GroupMakerFailure extends GroupMakerResources {
  GroupMakerFailure({@required friends}) : super(friends: friends);
}
