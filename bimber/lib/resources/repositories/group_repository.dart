import 'package:bimber/models/group.dart';

abstract class GroupRepository {
  Future<List<Group>> fetchGroupList();
  Future<List<Group>> fetchGroupInvitationList();
  Future<bool> acceptGroupInvitation(String groupId);
  Future<bool> cancelGroupInvitation(String groupId);
}
