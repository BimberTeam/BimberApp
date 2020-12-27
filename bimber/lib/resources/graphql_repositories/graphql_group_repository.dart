import 'package:bimber/bloc/discover/discover_bloc.dart';
import 'package:bimber/models/group.dart';
import 'package:bimber/models/message.dart';
import 'package:bimber/models/t_t_l.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/models/voting_result.dart';
import 'package:bimber/resources/graphql_repositories/common.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/graphql/queries.dart' as query;
import 'package:bimber/graphql/mutations.dart' as mutation;
import 'package:bimber/ui/common/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlGroupRepository extends GroupRepository {
  final ValueNotifier<GraphQLClient> client;

  GraphqlGroupRepository({@required this.client});

  @override
  Future<Message> acceptGroupInvitation(String groupId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.acceptGroupRequest,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "input": {"groupId": groupId}
        });

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return Message.fromJson(queryResult.data['acceptGroupInvitation']);
  }

  @override
  Future<Message> addToGroup(String userId, String groupId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.addToGroup,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"groupId": groupId, "userId": userId});

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return Message.fromJson(queryResult.data['addFriendToGroup']);
  }

  @override
  Future<Message> cancelGroupInvitation(String groupId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.rejectGroupRequest,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "input": {"groupId": groupId}
        });

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return Message.fromJson(queryResult.data['rejectGroupInvitation']);
  }

  @override
  Future<Message> createGroup(List<String> memberIds) async {
    final MutationOptions options = MutationOptions(
        document: mutation.createGroup,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"usersId": memberIds});

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return Message.fromJson(queryResult.data['createGroup']);
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
  Future<Group> fetchGroup(String groupId) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.group,
        fetchResults: true,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"id": groupId});

    final queryResult =
        await client.value.query(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return Group.fromJson(queryResult.data['group']);
  }

  @override
  Future<List<User>> fetchGroupCandidates(String groupId) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.groupCandidates,
        fetchResults: true,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"id": groupId});

    final queryResult =
        await client.value.query(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return (queryResult.data['groupCandidates'] as List)
        .map((json) => User.fromJson(json))
        .toList();
  }

  @override
  Future<Message> voteAgainst(String groupId, String userId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.voteAgainst,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"userId": userId, "groupId": groupId});

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return Message.fromJson(queryResult.data['rejectGroupPendingUser']);
  }

  @override
  Future<Message> voteFor(String groupId, String userId) async {
    final MutationOptions options = MutationOptions(
        document: mutation.voteFor,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"userId": userId, "groupId": groupId});

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return Message.fromJson(queryResult.data['acceptGroupPendingUser']);
  }

  @override
  Future<List<VotingResult>> fetchVotingResults(String groupId) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.votingResults,
        fetchResults: true,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"id": groupId});

    final queryResult =
        await client.value.query(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return (queryResult.data['groupCandidatesResult'] as List)
        .map((json) => VotingResult.fromJson(json))
        .toList();
  }

  @override
  Future<List<Group>> fetchGroupSuggestion(int limit) async {
    final range = (await getRangePreference()).round() * 1000;
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.groupSuggestions,
        fetchResults: true,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"range": range, "limit": limit});

    final queryResult =
        await client.value.query(options).timeout(Duration(seconds: 10));
    checkQueryResultForErrors(queryResult);

    return (queryResult.data['suggestGroups'] as List)
        .map((json) => Group.fromJson(json))
        .toList();
  }

  @override
  Future<Message> swipeGroup(SwipeType swipeType, String groupId) async {
    final MutationOptions options = MutationOptions(
        document: swipeType == SwipeType.LIKE
            ? mutation.swipeToLike
            : mutation.swipeToDislike,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"groupId": groupId});

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return swipeType == SwipeType.LIKE
        ? Message.fromJson(queryResult.data['swipeToLike'])
        : Message.fromJson(queryResult.data['swipeToDislike']);
  }

  @override
  Future<DateTime> fetchGroupTTL(String groupId) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.groupTTL,
        fetchResults: true,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"groupId": groupId});

    final queryResult =
        await client.value.query(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    TTL groupTTL = TTL.fromJson(queryResult.data['groupTTL']);

    return DateTime(groupTTL.year, groupTTL.month, groupTTL.day, groupTTL.hour,
        groupTTL.minute, groupTTL.second);
  }
}
