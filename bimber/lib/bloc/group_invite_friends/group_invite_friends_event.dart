part of 'group_invite_friends_bloc.dart';

@immutable
abstract class GroupInviteFriendsEvent extends Equatable {
  const GroupInviteFriendsEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitGroupInviteFriends extends GroupInviteFriendsEvent {}

class InviteFriendsToGroup extends GroupInviteFriendsEvent {
  final List<String> memberIds;

  InviteFriendsToGroup({@required this.memberIds});

  @override
  List<Object> get props => [memberIds];
}
