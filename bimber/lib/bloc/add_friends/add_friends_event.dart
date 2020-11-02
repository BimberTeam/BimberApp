part of 'add_friend_bloc.dart';

@immutable
abstract class AddFriendsEvent extends Equatable {
  const AddFriendsEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitAddFriends extends AddFriendsEvent {}

class AddFriendsToGroup extends AddFriendsEvent {
  final List<String> memberIds;

  AddFriendsToGroup({@required this.memberIds});

  @override
  List<Object> get props => [memberIds];
}
