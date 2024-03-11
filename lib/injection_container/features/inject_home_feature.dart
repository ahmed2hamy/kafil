import 'package:get_it/get_it.dart';
import 'package:kafil/core/network/network_client.dart';
import 'package:kafil/core/network/network_info.dart';
import 'package:kafil/features/home/data/data_sources/remote/home_reomte_data_source.dart';
import 'package:kafil/features/home/data/repositories/home_repository_impl.dart';
import 'package:kafil/features/home/domain/repositories/home_repository.dart';
import 'package:kafil/features/home/domain/use_cases/get_countries_use_case.dart';
import 'package:kafil/features/home/domain/use_cases/get_services_use_case.dart';
import 'package:kafil/features/home/presentation/manager/home_cubit/home_cubit.dart';

void injectHomeFeature(GetIt sl) {
  ///State Management:
  sl.registerLazySingleton<HomeCubit>(
    () => HomeCubit(
      getCountriesUseCase: sl<GetCountriesUseCase>(),
      getServicesUseCase: sl<GetServicesUseCase>(),
    ),
  );

  ///UseCases:
  sl.registerFactory<GetCountriesUseCase>(
    () => GetCountriesUseCase(
      homeRepository: sl<HomeRepository>(),
    ),
  );
  sl.registerFactory<GetServicesUseCase>(
    () => GetServicesUseCase(
      homeRepository: sl<HomeRepository>(),
    ),
  );

  ///Repositories:
  sl.registerFactory<HomeRepository>(
    () => HomeRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      homeRemoteDataSource: sl<HomeRemoteDataSource>(),
    ),
  );

  ///DataSource - Remote:
  sl.registerFactory<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      networkClient: sl<NetworkClient>(),
    ),
  );
}
