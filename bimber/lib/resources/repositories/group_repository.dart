import 'package:bimber/models/group.dart';
import 'package:bimber/models/message.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/models/voting_result.dart';

abstract class GroupRepository {
  Future<List<Group>> fetchGroupList({fetchCache = false});
  Future<List<Group>> fetchGroupInvitationList({fetchCache = false});
  Future<Message> acceptGroupInvitation(String groupId);
  Future<Message> cancelGroupInvitation(String groupId);
  Future<Message> createGroup(List<String> memberIds);
  Future<Message> addToGroup(String userId, String groupId);
  Future<Group> fetchGroup(String groupId);
  Future<List<User>> fetchGroupCandidates(String groupId);
  Future<List<VotingResult>> fetchVotingResults(String groupId);
  Future<Message> voteFor(String groupId, String userId);
  Future<Message> voteAgainst(String groupId, String userId);
}
