part of 'group_add_bloc.dart';

@immutable
abstract class GroupAddEvent extends Equatable {
  const GroupAddEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitGroupAdd extends GroupAddEvent {}

class AddToGroup extends GroupAddEvent {
  final List<String> groupsIds;

  AddToGroup({@required this.groupsIds});

  @override
  List<Object> get props => [groupsIds];
}
