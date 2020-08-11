import 'package:bimber/app.dart';
import 'package:bimber/bloc_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/flare_cache_asset.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> preloadFlare() async {
  Iterable<String> assets = ['assets/Bimber-logo.flr'];
  Iterable<Future<FlareCacheAsset>> futures = assets.map((String asset) =>
      cachedActor(AssetFlare(bundle: rootBundle, name: asset)));
  return Future.wait(futures);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await preloadFlare();

  Bloc.observer = SimpleBlocObserver();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(App());
}
