import 'package:bimber/models/group.dart';

abstract class GroupRepository {
  List<Group> getCachedGroupList();
  Future<List<Group>> fetchGroupList();
  Future<List<Group>> fetchGroupInvitationList();
  Future<bool> acceptGroupInvitation(String groupId);
  Future<bool> cancelGroupInvitation(String groupId);
  Future<bool> createGroup(List<String> memberIds);
  Future<bool> addToGroup(String userId);
}
