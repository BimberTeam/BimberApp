import 'package:bimber/models/group.dart';
import 'package:bimber/models/message.dart';
import 'package:bimber/models/status.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/models/voting_result.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/common/fixtures.dart';

class MockGroupRepository extends GroupRepository {
  @override
  Future<Message> acceptGroupInvitation(String groupId) {
    return Future.value(Message(status: Status.OK, message: "ok"));
  }

  @override
  Future<Message> cancelGroupInvitation(String groupId) {
    return Future.value(Message(status: Status.OK, message: "ok"));
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
  Future<Message> addToGroup(String userId, String groupId) {
    return Future.value(Message(status: Status.OK, message: "ok"));
  }

  @override
  Future<Message> createGroup(List<String> memberIds) {
    return Future.value(Message(status: Status.OK, message: "ok"));
  }

  @override
  Future<Group> fetchGroup(String groupId) {
    return Future.value(Fixtures.getGroup(groupId));
  }

  @override
  Future<List<User>> fetchGroupCandidates(String groupId) {
    return Future.value(Fixtures.getUSAPresidents());
  }

  @override
  Future<Message> voteAgainst(String groupId, String userId) {
    return Future.value(Message(status: Status.OK, message: "ok"));
  }

  @override
  Future<Message> voteFor(String groupId, String userId) {
    return Future.value(Message(status: Status.OK, message: "ok"));
  }

  @override
  Future<List<VotingResult>> fetchVotingResults(String groupId) {
    return Future.delayed(
        Duration(seconds: 1), () => Fixtures.getVotingResults());
  }
}
