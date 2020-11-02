import 'package:bimber/models/group.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/common/fixtures.dart';

class MockGroupRepository extends GroupRepository {
  @override
  Future<bool> acceptGroupInvitation(String groupId) {
    return Future.value(true);
  }

  @override
  Future<bool> cancelGroupInvitation(String groupId) {
    return Future.value(true);
  }

  @override
  Future<List<Group>> fetchGroupInvitationList({fetchCache = false}) {
    if (fetchCache) return Future.value(Fixtures.getGroups());
    return Future.delayed(Duration(seconds: 1), () => Fixtures.getGroups());
  }

  @override
  Future<List<Group>> fetchGroupList({fetchCache = false}) {
    if (fetchCache) return Future.value(Fixtures.getGroups());
    return Future.delayed(Duration(seconds: 1), () => Fixtures.getGroups());
  }

  @override
  Future<bool> addToGroup(String userId, String groupId) {
    return Future.delayed(Duration(seconds: 1), () => true);
  }

  @override
  Future<bool> createGroup(List<String> memberIds) {
    return Future.delayed(
        Duration(seconds: 1), () => memberIds.length > 3 ? true : false);
  }

  @override
  Future<Group> fetchGroup(String groupId) {
    return Future.value(Fixtures.getGroup(groupId));
  }

  @override
  Future<List<String>> fetchFriendCandidates(String groupId) {
    return Future.value(["aaa"]);
  }

  @override
  Future<List<User>> fetchGroupMemberCandidates(String groupId,
      {fetchCache = false}) {
    // TODO: implement fetchGroupMemberCandidates
    throw UnimplementedError();
  }
}
