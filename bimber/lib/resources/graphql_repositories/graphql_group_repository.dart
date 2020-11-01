import 'package:bimber/models/group.dart';
import 'package:bimber/models/message.dart';
import 'package:bimber/models/status.dart';
import 'package:bimber/resources/graphql_repositories/common.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/graphql/queries.dart' as query;
import 'package:bimber/graphql/mutations.dart' as mutation;
import 'package:bimber/ui/common/fixtures.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlGroupRepository extends GroupRepository {
  final ValueNotifier<GraphQLClient> client;

  GraphqlGroupRepository({@required this.client});

  @override
  Future<bool> acceptGroupInvitation(String groupId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.acceptGroupRequest,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "input": {"groupId": groupId}
        });

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    Message message =
        Message.fromJson(queryResult.data['acceptGroupInvitation']);

    if (message.status == Status.ERROR)
      throw GraphqlException(message: message.message);

    return true;
  }

  @override
  Future<bool> addToGroup(String userId, String groupId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.addToGroup,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"groupId": groupId, "friendId": userId});

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    Message message = Message.fromJson(queryResult.data['addFriendToGroup']);

    if (message.status == Status.ERROR)
      throw GraphqlException(message: message.message);

    return true;
  }

  @override
  Future<bool> cancelGroupInvitation(String groupId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.rejectGroupRequest,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "input": {"groupId": groupId}
        });

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    Message message =
        Message.fromJson(queryResult.data['rejectGroupInvitation']);

    if (message.status == Status.ERROR)
      throw GraphqlException(message: message.message);

    return true;
  }

  @override
  Future<bool> createGroup(List<String> memberIds) async {
    final MutationOptions options = MutationOptions(
        document: mutation.createGroup,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"usersId": memberIds});

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    Message message = Message.fromJson(queryResult.data['createGroup']);

    if (message.status == Status.ERROR)
      throw GraphqlException(message: message.message);

    return true;
  }

  @override
  Future<List<Group>> fetchGroupInvitationList({fetchCache = false}) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.groupInvitationsList,
        fetchResults: true,
        fetchPolicy:
            fetchCache ? FetchPolicy.cacheFirst : FetchPolicy.networkOnly);

    final queryResult =
        await client.value.query(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return (queryResult.data['me']['groupInvitations'] as List)
        .map((json) => Group.fromJson(json))
        .toList();
  }

  @override
  Future<List<Group>> fetchGroupList({fetchCache = false}) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.groupList,
        fetchResults: true,
        fetchPolicy:
            fetchCache ? FetchPolicy.cacheFirst : FetchPolicy.networkOnly);

    final queryResult =
        await client.value.query(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return (queryResult.data['me']['groups'] as List)
        .map((json) => Group.fromJson(json))
        .toList();
  }

  @override
  Future<Group> fetchGroup(String groupId) {
    return Future.value(Fixtures.getGroup(groupId));
  }

  @override
  Future<List<String>> fetchPossibleFriend(String groupId) {
    return Future.value(["aaa"]);
  }
}
