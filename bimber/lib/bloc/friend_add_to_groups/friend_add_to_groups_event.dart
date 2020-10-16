part of 'friend_add_to_groups_bloc.dart';

@immutable
abstract class AddFriendToGroupsEvent extends Equatable {
  const AddFriendToGroupsEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitAddFriendToGroups extends AddFriendToGroupsEvent {}

class AddFriendToGroupSubmit extends AddFriendToGroupsEvent {
  final List<String> groupsIds;

  AddFriendToGroupSubmit({@required this.groupsIds});

  @override
  List<Object> get props => [groupsIds];
}
