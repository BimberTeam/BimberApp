import 'package:bimber/models/account_data.dart';
import 'package:bimber/models/edit_account_data.dart';
import 'package:bimber/models/message.dart';
import 'package:bimber/models/register_account_data.dart';
import 'package:bimber/resources/graphql_repositories/common.dart';
import 'package:bimber/resources/repositories/account_repository.dart';
import 'package:bimber/resources/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"email": email});

    final queryResult =
        await client.value.query(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return queryResult.data["accountExists"] as bool;
  }

  @override
  Future<bool> isLoggedIn() async {
    final hasToken = await TokenService.hasToken();
    if (!hasToken) return false;

    final WatchQueryOptions options =
        WatchQueryOptions(document: query.me, fetchResults: true);

    final queryResult =
        await client.value.query(options).timeout(Duration(seconds: 5));

    try {
      checkQueryResultForErrors(queryResult);
    } on GraphqlConnectionError catch (e) {
      throw e;
    } catch (e) {
      await TokenService.deleteToken();
      return false;
    }

    // No errors so we are logged in
    return true;
  }

  @override
  Future<void> login(String email, String password) async {
    final MutationOptions options = MutationOptions(
        document: mutation.login,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"email": email, "password": password});

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    final token = queryResult.data["login"]["token"];
    await TokenService.persistToken(token);

    return;
  }

  @override
  Future<void> logout() async {
    await TokenService.deleteToken();
  }

  @override
  Future<AccountData> register(RegisterAccountData data) async {
    Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    RegisterAccountData newData = data.copyWith(longitude: position.longitude, latitude: position.latitude);
    final MutationOptions options = MutationOptions(
        document: mutation.register,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: newData.toJson());
    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return AccountData.fromJson(queryResult.data["register"]);
  }

  @override
  Future<void> editAccount(EditAccountData data) async {
    final MutationOptions options = MutationOptions(
        document: mutation.editAccount,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: data.toJson());

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return;
  }

  @override
  Future<AccountData> fetchMe({bool useCache = true}) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.me,
        fetchResults: true,
        fetchPolicy:
            useCache ? FetchPolicy.cacheFirst : FetchPolicy.networkOnly);

    final queryResult =
        await client.value.query(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return AccountData.fromJson(queryResult.data["me"]);
  }

  @override
  Future<Message> deleteAccount() async {
    final MutationOptions options = MutationOptions(
        document: mutation.deleteAccount, fetchPolicy: FetchPolicy.networkOnly);

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return Message.fromJson(queryResult.data['deleteAccount']);
  }

  @override
  Future<void> updateLocation() async {
    Position position;
    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    } catch (e) {
      return;
    }

    final MutationOptions options = MutationOptions(
        document: mutation.updateLocation,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "latitude": position.latitude,
          "longitude": position.longitude
        });

    final queryResult =
        await client.value.mutate(options).timeout(Duration(seconds: 5));
    checkQueryResultForErrors(queryResult);

    return;
  }
}
