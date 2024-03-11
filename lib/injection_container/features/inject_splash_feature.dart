import 'package:get_it/get_it.dart';
import 'package:kafil/core/network/network_client.dart';
import 'package:kafil/core/network/network_info.dart';
import 'package:kafil/features/splash/data/data_sources/remote/splash_remote_data_source.dart';
import 'package:kafil/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:kafil/features/splash/domain/repositories/splash_repository.dart';
import 'package:kafil/features/splash/domain/use_cases/get_app_dependencies_use_case.dart';
import 'package:kafil/features/splash/presentation/manager/splash_cubit/splash_cubit.dart';

void injectSplashFeature(GetIt sl) {
  ///State Management:
  sl.registerLazySingleton<SplashCubit>(
    () => SplashCubit(
      getAppDependenciesUseCase: sl<GetAppDependenciesUseCase>(),
    ),
  );

  ///UseCases:
  sl.registerFactory<GetAppDependenciesUseCase>(
    () => GetAppDependenciesUseCase(
      splashRepository: sl<SplashRepository>(),
    ),
  );

  ///Repositories:
  sl.registerFactory<SplashRepository>(
    () => SplashRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      splashRemoteDataSource: sl<SplashRemoteDataSource>(),
    ),
  );

  ///DataSource - Remote:
  sl.registerFactory<SplashRemoteDataSource>(
    () => SplashRemoteDataSourceImpl(
      networkClient: sl<NetworkClient>(),
    ),
  );
}
