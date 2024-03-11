import 'package:get_it/get_it.dart';
import 'package:kafil/core/database/database.dart';
import 'package:kafil/core/network/network_client.dart';
import 'package:kafil/core/network/network_info.dart';
import 'package:kafil/features/login/data/data_sources/local/login_local_data_source.dart';
import 'package:kafil/features/login/data/data_sources/remote/login_remote_data_source.dart';
import 'package:kafil/features/login/data/repositories/login_repository_impl.dart';
import 'package:kafil/features/login/domain/repositories/login_repository.dart';
import 'package:kafil/features/login/domain/use_cases/auto_login_use_case.dart';
import 'package:kafil/features/login/domain/use_cases/login_use_case.dart';
import 'package:kafil/features/login/domain/use_cases/logout_use_case.dart';
import 'package:kafil/features/login/presentation/manager/login_cubit/login_cubit.dart';

void injectLoginFeature(GetIt sl) {
  ///State Management:
  sl.registerLazySingleton<LoginCubit>(
    () => LoginCubit(
      loginUseCase: sl<LoginUseCase>(),
      autoLoginUseCase: sl<AutoLoginUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
    ),
  );

  ///UseCases:
  sl.registerFactory<LoginUseCase>(
    () => LoginUseCase(
      loginRepository: sl<LoginRepository>(),
    ),
  );

  sl.registerFactory<AutoLoginUseCase>(
    () => AutoLoginUseCase(
      loginRepository: sl<LoginRepository>(),
    ),
  );

  sl.registerFactory<LogoutUseCase>(
    () => LogoutUseCase(
      loginRepository: sl<LoginRepository>(),
    ),
  );

  ///Repositories:
  sl.registerFactory<LoginRepository>(
    () => LoginRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      loginRemoteDataSource: sl<LoginRemoteDataSource>(),
      loginLocalDataSource: sl<LoginLocalDataSource>(),
    ),
  );

  ///DataSource - Remote:
  sl.registerFactory<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(
      networkClient: sl<NetworkClient>(),
    ),
  );

  ///DataSource - Local:
  sl.registerFactory<LoginLocalDataSource>(
    () => LoginLocalDataSourceImpl(
      appDatabase: sl<AppDatabase>(),
    ),
  );
}
