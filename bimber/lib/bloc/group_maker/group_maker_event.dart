part of 'group_maker_bloc.dart';

@immutable
abstract class GroupMakerEvent extends Equatable {
  const GroupMakerEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitGroupMaker extends GroupMakerEvent {}

class CreateGroup extends GroupMakerEvent {
  final List<String> memberIds;

  CreateGroup({@required this.memberIds});

  @override
  List<Object> get props => [memberIds];
}
