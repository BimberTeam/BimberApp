part of 'group_invite_friends_bloc.dart';

@immutable
abstract class GroupInviteFriendsState extends Equatable {
  const GroupInviteFriendsState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class GroupInviteFriendsInitial extends GroupInviteFriendsState {}

class GroupInviteFriendsError extends GroupInviteFriendsState {
  final String message;

  GroupInviteFriendsError({@required this.message});

  @override
  List<Object> get props => [message];
}

class GroupInviteFriendsFetched extends GroupInviteFriendsState {
  final List<User> possibleMembers;

  GroupInviteFriendsFetched({@required this.possibleMembers});

  @override
  List<Object> get props => [possibleMembers];
}

class GroupInviteFriendsLoading extends GroupInviteFriendsState {}

class GroupInviteFriendsSuccess extends GroupInviteFriendsState {}

class GroupInviteFriendsFailure extends GroupInviteFriendsState {
  final String message;

  GroupInviteFriendsFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
