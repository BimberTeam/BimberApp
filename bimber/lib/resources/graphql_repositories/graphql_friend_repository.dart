import 'package:bimber/models/message.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/graphql_repositories/common.dart';
import 'package:bimber/resources/repositories/friend_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:bimber/graphql/queries.dart' as query;
import 'package:bimber/graphql/mutations.dart' as mutation;

class GraphqlFriendRepository extends FriendRepository {
  final ValueNotifier<GraphQLClient> client;

  GraphqlFriendRepository({@required this.client});

  @override
  Future<Message> acceptInvitation(String friendId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.acceptFriendRequest,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "input": {"id": friendId}
        });

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return Message.fromJson(queryResult.data['acceptFriendRequest']);
  }

  @override
  Future<Message> addFriend(String friendId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.addFriend,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "input": {"id": friendId}
        });

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return Message.fromJson(queryResult.data['sendFriendRequest']);
  }

  @override
  Future<Message> declineInvitation(String userId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.denyFriendRequest,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "input": {"id": userId}
        });

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return Message.fromJson(queryResult.data['denyFriendRequest']);
  }

  @override
  Future<Message> deleteFriend(String friendId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.removeFriend,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "input": {"id": friendId}
        });

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return Message.fromJson(queryResult.data['removeFriend']);
  }

  @override
  Future<List<User>> fetchFriendInvitationList(
      {bool fetchCache = false}) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.friendInvitationList,
        fetchResults: true,
        fetchPolicy:
            fetchCache ? FetchPolicy.cacheFirst : FetchPolicy.networkOnly);
    final queryResult =
        await client.value.query(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return (queryResult.data['me']['friendRequests'] as List)
        .map((json) => User.fromJson(json))
        .toList();
  }

  @override
  Future<List<User>> fetchFriendsList({bool fetchCache = false}) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.friendsList,
        fetchResults: true,
        fetchPolicy:
            fetchCache ? FetchPolicy.cacheFirst : FetchPolicy.networkOnly);

    final queryResult =
        await client.value.query(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return (queryResult.data['me']['friends'] as List)
        .map((json) => User.fromJson(json))
        .toList();
  }

  @override
  Future<List<User>> fetchFriendCandidatesFromGroup(String groupId) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.groupMembersWithoutFriendship,
        fetchResults: true,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"id": groupId});

    final queryResult =
        await client.value.query(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return (queryResult.data['groupMembersWithoutFriendship'] as List)
        .map((json) => User.fromJson(json))
        .toList();
  }

  @override
  Future<List<User>> fetchFriendsWithoutGroupMembership(String groupId) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.listFriendsWithoutGroupMembership,
        fetchResults: true,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"id": groupId});

    final queryResult =
        await client.value.query(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return (queryResult.data['listFriendsWithoutGroupMembership'] as List)
        .map((json) => User.fromJson(json))
        .toList();
  }
}
