import 'package:bimber/models/account_data.dart';
import 'package:bimber/models/register_account_data.dart';
import 'package:bimber/resources/graphql_repositories/common.dart';
import 'package:bimber/resources/repositories/account_repository.dart';
import 'package:bimber/resources/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:bimber/graphql/queries.dart' as query;
import 'package:bimber/graphql/mutations.dart' as mutation;

class GraphqlAccountRepository extends AccountRepository {
  final ValueNotifier<GraphQLClient> client;

  GraphqlAccountRepository({@required this.client});

  @override
  Future<bool> checkIfEmailExists(String email) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.accountExists,
        fetchResults: true,
        variables: {"email": email});

    final queryResult = await client.value.query(options);
    checkQueryResultForErrors(queryResult);

    return queryResult.data["accountExists"] as bool;
  }

  @override
  Future<bool> isLoggedIn() async {
    final hasToken = await TokenService.hasToken();
    if (!hasToken) return false;

    final WatchQueryOptions options =
        WatchQueryOptions(document: query.profile, fetchResults: true);

    final queryResult = await client.value.query(options);

    try {
      checkQueryResultForErrors(queryResult);
    } on GraphqlConnectionError catch (e) {
      throw e;
    } catch (e) {
      print(e);
      return false;
    }

    // No errors so we are logged in
    return true;
  }

  @override
  Future<bool> login(String email, String password) async {
    final MutationOptions options = MutationOptions(
        document: mutation.login,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"email": email, "password": password});

    final queryResult = await client.value.mutate(options);

    try {
      checkQueryResultForErrors(queryResult);
    } on GraphqlConnectionError catch (e) {
      throw e;
    } catch (e) {
      print(e);
      return false;
    }

    final token = queryResult.data["login"]["token"];
    await TokenService.persistToken(token);

    return true;
  }

  @override
  Future<void> logout() async {
    await TokenService.deleteToken();
  }

  @override
  Future<AccountData> register(RegisterAccountData data) async {
    final MutationOptions options = MutationOptions(
        document: mutation.register,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: data.toJson());

    final queryResult = await client.value.mutate(options);
    checkQueryResultForErrors(queryResult);

    return AccountData.fromJson(queryResult.data["register"]);
  }
}
