import 'package:bimber/models/group.dart';
import 'package:bimber/models/group_candidate.dart';
import 'package:bimber/models/user.dart';

abstract class GroupRepository {
  Future<List<Group>> fetchGroupList({fetchCache = false});
  Future<List<Group>> fetchGroupInvitationList({fetchCache = false});
  Future<bool> acceptGroupInvitation(String groupId);
  Future<bool> cancelGroupInvitation(String groupId);
  Future<bool> createGroup(List<String> memberIds);
  Future<bool> addToGroup(String userId, String groupId);
  Future<Group> fetchGroup(String groupId);
  Future<List<User>> fetchGroupCandidates(String groupId);
  Future<List<GroupCandidate>> fetchGroupCandidateResults(String groupId);
  Future<bool> voteFor(String groupId, String userId);
  Future<bool> voteAgainst(String groupId, String userId);
}
