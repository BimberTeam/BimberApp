import 'package:bimber/models/user.dart';

abstract class FriendRepository {
  Future<bool> deleteFriend(String friendId);
  Future<bool> addFriend(String friendId);
  Future<List<User>> fetchFriendsList({bool fetchCache = false});
  Future<List<User>> fetchFriendInvitationList();
  Future<bool> acceptInvitation(String friendId);
  Future<bool> cancelInvitation(String friendId);
  Future<List<String>> checkIfCanBeAddedToFriend(List<String> users);
}
