import 'package:bimber/models/group.dart';
import 'package:bimber/resources/group_repository.dart';
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
}
