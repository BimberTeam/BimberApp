import 'package:bimber/models/message.dart';
import 'package:bimber/models/status.dart';
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
  Future<bool> acceptInvitation(String friendId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.acceptFriendRequest,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "input": {"id": friendId}
        });

    final queryResult = await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    Message message = Message.fromJson(queryResult.data['acceptFriendRequest']);

    if (message.status == Status.ERROR)
      throw GraphqlException(message: message.message);

    return true;
  }

  @override
  Future<bool> addFriend(String friendId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.addFriend,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "input": {"id": friendId}
        });

    final queryResult = await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    Message message = Message.fromJson(queryResult.data['sendFriendRequest']);

    if (message.status == Status.ERROR)
      throw GraphqlException(message: message.message);

    return true;
  }

  @override
  Future<bool> declineInvitation(String userId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.denyFriendRequest,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "input": {"id": userId}
        });

    final queryResult = await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    Message message = Message.fromJson(queryResult.data['denyFriendRequest']);

    if (message.status == Status.ERROR)
      throw GraphqlException(message: message.message);

    return true;
  }

  @override
  Future<bool> deleteFriend(String friendId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.removeFriend,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "input": {"id": friendId}
        });

    final queryResult = await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    Message message = Message.fromJson(queryResult.data['removeFriend']);

    if (message.status == Status.ERROR)
      throw GraphqlException(message: message.message);

    return true;
  }

  @override
  Future<List<User>> fetchFriendInvitationList(
      {bool fetchCache = false}) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.friendInvitationList,
        fetchResults: true,
        fetchPolicy:
            fetchCache ? FetchPolicy.cacheFirst : FetchPolicy.networkOnly);
    final queryResult = await client.value.query(options).timeout(Duration(seconds: 5));
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

    final queryResult = await client.value.query(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return (queryResult.data['me']['friends'] as List)
        .map((json) => User.fromJson(json))
        .toList();
  }
}
