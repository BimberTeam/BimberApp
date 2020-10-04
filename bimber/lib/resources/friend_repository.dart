import 'package:bimber/models/user.dart';
import 'package:bimber/ui/common/fixtures.dart';

abstract class FriendRepository {
  Future<bool> deleteFriend(String friendId);
  Future<bool> addFriend(String friendId);
  Future<List<User>> fetchFriendsList();
  Future<List<User>> fetchFriendInvitationList();
  Future<bool> acceptInvitation(String friendId);
  Future<bool> cancelInvitation(String friendId);
}

class MockFriendRepository extends FriendRepository{
  @override
  Future<bool> acceptInvitation(String friendId) {
    return Future.value(true);
  }

  @override
  Future<bool> addFriend(String friendId) {
    return Future.value(true);
  }

  @override
  Future<bool> deleteFriend(String friendId) {
    return Future.value(true);
  }

  @override
  Future<List<User>> fetchFriendInvitationList() {
    return Future.value(Fixtures.getUsersList());
  }

  @override
  Future<List<User>> fetchFriendsList() {
    return Future.value(Fixtures.getUsersList());
  }

  @override
  Future<bool> cancelInvitation(String friendId) {
    return Future.value(true);
  }

}

