import 'package:get_it/get_it.dart';
import 'package:kafil/core/network/network_client.dart';
import 'package:kafil/core/network/network_info.dart';
import 'package:kafil/features/register/data/data_sources/remote/register_remote_data_source.dart';
import 'package:kafil/features/register/data/repositories/register_repository_impl.dart';
import 'package:kafil/features/register/domain/repositories/register_repository.dart';
import 'package:kafil/features/register/domain/use_cases/register_use_case.dart';
import 'package:kafil/features/register/presentation/manager/register_cubit/register_cubit.dart';
import 'package:kafil/features/register/presentation/manager/register_provider.dart';

void injectRegisterFeature(GetIt sl) {
  ///State Management:
  sl.registerLazySingleton<RegisterProvider>(
    () => RegisterProvider(),
  );
  sl.registerLazySingleton<RegisterCubit>(
    () => RegisterCubit(
      registerUseCase: sl<RegisterUseCase>(),
    ),
  );

  ///UseCases:
  sl.registerFactory<RegisterUseCase>(
    () => RegisterUseCase(
      registerRepository: sl<RegisterRepository>(),
    ),
  );

  ///Repositories:
  sl.registerFactory<RegisterRepository>(
    () => RegisterRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      registerRemoteDataSource: sl<RegisterRemoteDataSource>(),
    ),
  );

  ///DataSource - Remote:
  sl.registerFactory<RegisterRemoteDataSource>(
    () => RegisterRemoteDataSourceImpl(
      networkClient: sl<NetworkClient>(),
    ),
  );
}
