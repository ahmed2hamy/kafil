import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kafil/core/database/database.dart';
import 'package:kafil/core/network/network_client.dart';
import 'package:kafil/core/network/network_info.dart';
import 'package:kafil/injection_container/features/inject_home_feature.dart';
import 'package:kafil/injection_container/features/inject_login_feature.dart';
import 'package:kafil/injection_container/features/inject_register_feature.dart';
import 'package:kafil/injection_container/features/inject_splash_feature.dart';

final GetIt sl = GetIt.instance;

Future<void> init(String baseUrl) async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Features:
  ///
  injectSplashFeature(sl);

  injectLoginFeature(sl);

  injectRegisterFeature(sl);

  injectHomeFeature(sl);

  ///Core:
  ///
  sl.registerLazySingleton<NetworkClient>(
    () => NetworkClient(
      sl<Dio>(),
      baseUrl,
    ),
  );
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
}
