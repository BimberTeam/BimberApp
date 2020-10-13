part of 'group_create_bloc.dart';

@immutable
abstract class GroupCreateState extends Equatable {
  const GroupCreateState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class GroupCreateInitial extends GroupCreateState {}

class GroupCreateError extends GroupCreateState {
  final String message;

  GroupCreateError({@required this.message});

  @override
  List<Object> get props => [message];
}

class GroupCreateResources extends GroupCreateState {
  final List<User> friends;

  GroupCreateResources({@required this.friends});

  @override
  List<Object> get props => [friends];

  List<User> getFriends() {
    return friends;
  }
}

class GroupCreateFetched extends GroupCreateResources {
  GroupCreateFetched({@required friends}) : super(friends: friends);
}

class GroupCreateLoading extends GroupCreateResources {
  GroupCreateLoading({@required friends}) : super(friends: friends);
}

class GroupCreateSuccess extends GroupCreateResources {
  GroupCreateSuccess({@required friends}) : super(friends: friends);
}

class GroupCreateFailure extends GroupCreateResources {
  GroupCreateFailure({@required friends}) : super(friends: friends);
}
