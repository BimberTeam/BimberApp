part of 'group_info_bloc.dart';

@immutable
abstract class GroupInfoEvent extends Equatable {
  const GroupInfoEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitGroupInfo extends GroupInfoEvent {}

class RefreshGroupInfo extends GroupInfoEvent {}

class AddMemberToFriends extends GroupInfoEvent {
  final String id;

  AddMemberToFriends({@required this.id});

  @override
  List<Object> get props => [id];
}
