import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/friend_repository.dart';
import 'package:bimber/ui/common/fixtures.dart';

class MockFriendRepository extends FriendRepository {
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
    return Future.value(false);
  }

  @override
  Future<List<User>> fetchFriendInvitationList() {
    return Future.delayed(Duration(seconds: 1), () => Fixtures.getUsersList());
  }

  @override
  Future<List<User>> fetchFriendsList() {
    return Future.delayed(Duration(seconds: 1), () => Fixtures.getUsersList());
  }

  @override
  Future<bool> cancelInvitation(String friendId) {
    return Future.value(true);
  }
}
