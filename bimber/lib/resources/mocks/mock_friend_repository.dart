import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/friend_repository.dart';
import 'package:bimber/ui/common/fixtures.dart';

class MockFriendRepository extends FriendRepository {
  List<User> _cachedFriends;

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
  Future<List<User>> fetchFriendsList({bool fetchCache = false}) {
    if (fetchCache && _cachedFriends != null)
      return Future.value(_cachedFriends);
    return Future.delayed(Duration(seconds: 1), () {
      _cachedFriends = Fixtures.getUsersList();
      return _cachedFriends;
    });
  }

  @override
  Future<bool> cancelInvitation(String friendId) {
    return Future.value(true);
  }

  @override
  Future<List<String>> checkIfCanBeAddedToFriend(List<String> users) {
    return Future.value(["aaa"]);
  }
}
