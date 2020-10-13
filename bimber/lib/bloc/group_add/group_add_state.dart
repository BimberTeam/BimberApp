part of 'group_add_bloc.dart';

@immutable
abstract class GroupAddState extends Equatable {
  const GroupAddState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class GroupAddInitial extends GroupAddState {}

class GroupAddError extends GroupAddState {
  final String message;

  GroupAddError({@required this.message});

  @override
  List<Object> get props => [message];
}

class GroupAddResources extends GroupAddState {
  final List<Group> groups;

  GroupAddResources({@required this.groups});

  @override
  List<Object> get props => [groups];

  List<Group> getGroups() {
    return groups;
  }
}

class GroupAddFetched extends GroupAddResources {
  GroupAddFetched({@required groups}) : super(groups: groups);
}

class GroupAddLoading extends GroupAddResources {
  GroupAddLoading({@required groups}) : super(groups: groups);
}

class AddToGroupsSuccess extends GroupAddResources {
  AddToGroupsSuccess({@required groups}) : super(groups: groups);
}

class AddToGroupFailure extends GroupAddResources {
  AddToGroupFailure({@required groups}) : super(groups: groups);
}
