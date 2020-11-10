import 'package:bimber/models/group.dart';
import 'package:bimber/models/group_candidate.dart';
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
  Future<List<User>> fetchCandidatesForVote(String groupId) {
    return Future.value(Fixtures.getUSAPresidents());
  }

  @override
  Future<List<GroupCandidate>> fetchGroupCandidates(String groupId) {
    return Future.delayed(
        Duration(seconds: 1), () => Fixtures.getGroupCandidates());
  }

  @override
  Future<bool> voteAgainst(String groupId, String userId) {
    return Future.value(true);
  }

  @override
  Future<bool> voteFor(String groupId, String userId) {
    return Future.value(true);
  }
}
