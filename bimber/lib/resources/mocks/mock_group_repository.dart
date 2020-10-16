import 'package:bimber/models/group.dart';
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
  Future<List<Group>> fetchGroupInvitationList() {
    return Future.delayed(Duration(seconds: 1), () => Fixtures.getGroups());
  }

  @override
  Future<List<Group>> fetchGroupList() {
    return Future.delayed(Duration(seconds: 1), () => Fixtures.getGroups());
  }

  @override
  Future<bool> addToGroup(String userId) {
    return Future.delayed(Duration(seconds: 1), () => true);
  }

  @override
  Future<bool> createGroup(List<String> memberIds) {
    return Future.delayed(
        Duration(seconds: 1), () => memberIds.length > 3 ? true : false);
  }

  @override
  List<Group> getCachedGroupList() {
    return Fixtures.getGroups();
  }
}
