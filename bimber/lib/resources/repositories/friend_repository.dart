import 'package:bimber/models/message.dart';
import 'package:bimber/models/user.dart';

abstract class FriendRepository {
  Future<Message> deleteFriend(String friendId);
  Future<Message> addFriend(String friendId);
  Future<List<User>> fetchFriendsList({bool fetchCache = false});
  Future<List<User>> fetchFriendInvitationList({bool fetchCache = false});
  Future<Message> acceptInvitation(String friendId);
  Future<Message> declineInvitation(String friendId);
  Future<List<User>> fetchFriendsWithoutGroupMembership(String groupId);
  Future<List<User>> fetchFriendCandidatesFromGroup(String groupId);
}
