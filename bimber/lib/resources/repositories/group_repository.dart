import 'package:bimber/models/group.dart';

abstract class GroupRepository {
  Future<List<Group>> fetchGroupList({fetchCache = false});
  Future<List<Group>> fetchGroupInvitationList({fetchCache = false});
  Future<bool> acceptGroupInvitation(String groupId);
  Future<bool> cancelGroupInvitation(String groupId);
  Future<bool> createGroup(List<String> memberIds);
  Future<bool> addToGroup(String userId, String groupId);
  Future<Group> fetchGroup(String groupId);
  Future<List<String>> fetchFriendCandidates(String groupId);
}
