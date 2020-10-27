import 'package:bimber/models/group.dart';
import 'package:bimber/models/message.dart';
import 'package:bimber/models/status.dart';
import 'package:bimber/resources/graphql_repositories/common.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/graphql/queries.dart' as query;
import 'package:bimber/graphql/mutations.dart' as mutation;
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

    final queryResult = await client.value.mutate(options);
    checkQueryResultForErrors(queryResult);

    Message message =
        Message.fromJson(queryResult.data['acceptGroupInvitation']);

    if (message.status == Status.ERROR)
      throw GraphqlException(message: message.message);

    return true;
  }

  @override
  Future<bool> addToGroup(String userId) {
    // TODO: implement addToGroup
    throw UnimplementedError();
  }

  @override
  Future<bool> cancelGroupInvitation(String groupId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.rejectGroupRequest,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "input": {"groupId": groupId}
        });

    final queryResult = await client.value.mutate(options);
    checkQueryResultForErrors(queryResult);

    Message message =
        Message.fromJson(queryResult.data['rejectGroupInvitation']);

    if (message.status == Status.ERROR)
      throw GraphqlException(message: message.message);

    return true;
  }

  @override
  Future<bool> createGroup(List<String> memberIds) {
    // TODO: implement createGroup
    throw UnimplementedError();
  }

  @override
  Future<List<Group>> fetchGroupInvitationList({fetchCache = false}) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.groupInvitationsList,
        fetchResults: true,
        fetchPolicy:
            fetchCache ? FetchPolicy.cacheFirst : FetchPolicy.networkOnly);

    final queryResult = await client.value.query(options);
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

    final queryResult = await client.value.query(options);
    checkQueryResultForErrors(queryResult);

    return (queryResult.data['me']['groups'] as List)
        .map((json) => Group.fromJson(json))
        .toList();
  }
}
