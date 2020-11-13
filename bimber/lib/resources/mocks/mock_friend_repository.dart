import 'package:bimber/models/message.dart';
import 'package:bimber/models/status.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/friend_repository.dart';
import 'package:bimber/ui/common/fixtures.dart';

class MockFriendRepository extends FriendRepository {
  List<User> _cachedFriends;

  @override
  Future<Message> acceptInvitation(String friendId) {
    return Future.value(Message(status: Status.OK, message: "ok"));
  }

  @override
  Future<Message> addFriend(String friendId) {
    return Future.value(Message(status: Status.OK, message: "ok"));
  }

  @override
  Future<Message> deleteFriend(String friendId) {
    return Future.value(Message(status: Status.OK, message: "ok"));
  }

  @override
  Future<List<User>> fetchFriendInvitationList({bool fetchCache = false}) {
    if (fetchCache) return Future.value(Fixtures.getUsersList());
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
  Future<Message> declineInvitation(String friendId) {
    return Future.value(Message(status: Status.OK, message: "ok"));
  }

  @override
  Future<List<User>> fetchFriendCandidatesFromGroup(String groupId) {
    return Future.value(Fixtures.getUSAPresidents());
  }

  @override
  Future<List<User>> fetchFriendsWithoutGroupMembership(String groupId) {
    return Future.value(Fixtures.getUSAPresidents());
  }
}
