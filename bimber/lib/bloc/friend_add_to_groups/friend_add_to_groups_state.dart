part of 'friend_add_to_groups_bloc.dart';

@immutable
abstract class AddFriendToGroupsState extends Equatable {
  const AddFriendToGroupsState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class AddFriendToGroupsInitial extends AddFriendToGroupsState {}

class AddFriendToGroupsError extends AddFriendToGroupsState {
  final String message;

  AddFriendToGroupsError({@required this.message});

  @override
  List<Object> get props => [message];
}

class AddFriendToGroupsResources extends AddFriendToGroupsState {
  final List<Group> groups;

  AddFriendToGroupsResources({@required this.groups});

  @override
  List<Object> get props => [groups];

  List<Group> getGroups() {
    return groups;
  }
}

class AddFriendToGroupsFetched extends AddFriendToGroupsResources {
  AddFriendToGroupsFetched({@required groups}) : super(groups: groups);
}

class AddFriendToGroupsLoading extends AddFriendToGroupsResources {
  AddFriendToGroupsLoading({@required groups}) : super(groups: groups);
}

class AddFriendToGroupsSuccess extends AddFriendToGroupsResources {
  AddFriendToGroupsSuccess({@required groups}) : super(groups: groups);
}

class AddFriendToGroupFailure extends AddFriendToGroupsResources {
  AddFriendToGroupFailure({@required groups}) : super(groups: groups);
}
