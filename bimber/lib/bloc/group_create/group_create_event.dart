part of 'group_create_bloc.dart';

@immutable
abstract class GroupCreateEvent extends Equatable {
  const GroupCreateEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitGroupCreate extends GroupCreateEvent {}

class CreateGroup extends GroupCreateEvent {
  final List<String> memberIds;

  CreateGroup({@required this.memberIds});

  @override
  List<Object> get props => [memberIds];
}
