import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/friend_repository.dart';

class GraphqlFriendRepository extends FriendRepository {
  @override
  Future<bool> acceptInvitation(String friendId) {
    // TODO: implement acceptInvitation
    throw UnimplementedError();
  }

  @override
  Future<bool> addFriend(String friendId) {
    // TODO: implement addFriend
    throw UnimplementedError();
  }

  @override
  Future<bool> cancelInvitation(String friendId) {
    // TODO: implement cancelInvitation
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteFriend(String friendId) {
    // TODO: implement deleteFriend
    throw UnimplementedError();
  }

  @override
  Future<List<User>> fetchFriendInvitationList({bool fetchCache = false}) {
    // TODO: implement fetchFriendInvitationList
    throw UnimplementedError();
  }

  @override
  Future<List<User>> fetchFriendsList({bool fetchCache = false}) {
    // TODO: implement fetchFriendsList
    throw UnimplementedError();
  }
}
