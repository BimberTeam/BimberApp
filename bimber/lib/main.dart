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
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> preloadFlare() async {
  Iterable<String> assets = ['assets/Bimber-logo.flr'];
  Iterable<Future<FlareCacheAsset>> futures = assets.map((String asset) =>
      cachedActor(AssetFlare(bundle: rootBundle, name: asset)));
  return Future.wait(futures);
}

String typenameDataIdFromObject(Object object) {
  if (object is Map<String, Object> &&
      object.containsKey('__typename') &&
      object.containsKey('id'))
    return "${object['__typename']}/${object['id']}";
  return null;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await preloadFlare();

  await DotEnv().load("assets/env/.env_dev");

  Bloc.observer = SimpleBlocObserver();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  final url = DotEnv().env["GRAPHQL_URL"];
  final HttpLink httpLink = HttpLink(url);
  final wsUrl = DotEnv().env["GRAPHQL_WS_URL"];
  final WebSocketLink webSocketLink = WebSocketLink(wsUrl);

  final AuthLink authLink = AuthLink(getToken: () async {
    final token = await TokenService.getToken();
    return '$token';
  });

  final Link link =
      Link.split((request) => request.isSubscription, webSocketLink, httpLink)
          .concat(authLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
    cache: GraphQLCache(
      dataIdFromObject: typenameDataIdFromObject,
    ),
    link: link,
  ));

  GraphqlClientService(client: client);

  runApp(App());
}
