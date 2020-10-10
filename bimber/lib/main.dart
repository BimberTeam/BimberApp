import 'package:bimber/app.dart';
import 'package:bimber/bloc_observer.dart';
import 'package:bimber/resources/services/graphql_service.dart';
import 'package:bimber/resources/services/token_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/flare_cache_asset.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> preloadFlare() async {
  Iterable<String> assets = ['assets/Bimber-logo.flr'];
  Iterable<Future<FlareCacheAsset>> futures = assets.map((String asset) =>
      cachedActor(AssetFlare(bundle: rootBundle, name: asset)));
  return Future.wait(futures);
}

String typenameDataIdFromObject(Object object) {
  // We do not support apollo caching yet due to neo4j lacking __typename__ field
  return null;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await preloadFlare();

  Bloc.observer = SimpleBlocObserver();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  final HttpLink httpLink = HttpLink(String.fromEnvironment("GRAPHQL_URL"));

  final AuthLink authLink = AuthLink(getToken: () async {
    final token = await TokenService.getToken();
    return 'Bearer $token';
  });

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
    cache: GraphQLCache(
      dataIdFromObject: typenameDataIdFromObject,
    ),
    link: link,
  ));

  GraphqlClientService(client: client);

  runApp(App());
}
