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
        variables: {"friendId": friendId});

    final queryResult = await client.value.mutate(options);
    checkQueryResultForErrors(queryResult);

    Message message = Message.fromJson(queryResult.data['acceptFriendRequest']);

    if (message.status == Status.ERROR)
      throw GraphqlException(message: message.message);

    return true;
  }

  @override
  Future<bool> addFriend(String friendId) {
    // TODO: implement addFriend
    throw UnimplementedError();
  }

  @override
  Future<bool> declineInvitation(String friendId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.denyFriendRequest,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"friendId": friendId});

    final queryResult = await client.value.mutate(options);
    checkQueryResultForErrors(queryResult);

    Message message = Message.fromJson(queryResult.data['denyFriendRequest']);

    if (message.status == Status.ERROR)
      throw GraphqlException(message: message.message);

    return true;
  }

  @override
  Future<bool> deleteFriend(String friendId) {
    // TODO: implement deleteFriend
    throw UnimplementedError();
  }

  @override
  Future<List<User>> fetchFriendInvitationList(
      {bool fetchCache = false}) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.friendInvitationList,
        fetchResults: true,
        fetchPolicy:
            fetchCache ? FetchPolicy.cacheFirst : FetchPolicy.networkOnly);

    final queryResult = await client.value.query(options);
    checkQueryResultForErrors(queryResult);

    return (queryResult.data['me']['requestedFriends']
            as List<Map<String, Object>>)
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

    final queryResult = await client.value.query(options);
    checkQueryResultForErrors(queryResult);

    return (queryResult.data['me']['friends'] as List<Map<String, Object>>)
        .map((json) => User.fromJson(json))
        .toList();
  }
}
