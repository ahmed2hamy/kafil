import 'package:dartz/dartz.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/models/exception.dart';
import 'package:kafil/core/models/failures.dart';
import 'package:kafil/core/network/network_info.dart';
import 'package:kafil/features/home/data/data_sources/remote/home_reomte_data_source.dart';
import 'package:kafil/features/home/domain/entities/countries.dart';
import 'package:kafil/features/home/domain/entities/services.dart';
import 'package:kafil/features/home/domain/repositories/home_repository.dart';
import 'package:kafil/features/home/domain/use_cases/get_countries_use_case.dart';
import 'package:kafil/features/home/domain/use_cases/get_services_use_case.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfo _networkInfo;
  final HomeRemoteDataSource _remoteDataSource;

  const HomeRepositoryImpl({
    required NetworkInfo networkInfo,
    required HomeRemoteDataSource homeRemoteDataSource,
  })  : _networkInfo = networkInfo,
        _remoteDataSource = homeRemoteDataSource;

  @override
  Future<Either<Failure, Countries>> getCountries(
      GetCountriesParams params) async {
    if (await _networkInfo.isConnected) {
      return _getCountries(params);
    } else {
      return const Left(ServerFailure(message: kNoConnectionString));
    }
  }

  Future<Either<Failure, Countries>> _getCountries(
      GetCountriesParams params) async {
    try {
      Countries countries = await _remoteDataSource.getCountries(params);

      return Right(countries);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Services>> getServices(GetServicesParams params) async {
    if (await _networkInfo.isConnected) {
      return _getServices(params);
    } else {
      return const Left(ServerFailure(message: kNoConnectionString));
    }
  }

  Future<Either<Failure, Services>> _getServices(
      GetServicesParams params) async {
    try {
      Services service = await _remoteDataSource.getServices(params);

      return Right(service);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }


}
