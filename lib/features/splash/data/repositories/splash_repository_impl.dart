import 'package:dartz/dartz.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/models/exception.dart';
import 'package:kafil/core/models/failures.dart';
import 'package:kafil/core/network/network_info.dart';
import 'package:kafil/features/splash/data/data_sources/remote/splash_remote_data_source.dart';
import 'package:kafil/features/splash/domain/entities/app_dependencies.dart';
import 'package:kafil/features/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final NetworkInfo _networkInfo;
  final SplashRemoteDataSource _remoteDataSource;

  const SplashRepositoryImpl({
    required NetworkInfo networkInfo,
    required SplashRemoteDataSource splashRemoteDataSource,
  })
      : _networkInfo = networkInfo,
        _remoteDataSource = splashRemoteDataSource;

  @override
  Future<Either<Failure, AppDependencies>> getAppDependencies() async {
    if (await _networkInfo.isConnected) {
      return _getAppDependencies();
    } else {
      return const Left(ServerFailure(message: kNoConnectionString));
    }
  }

  Future<Either<Failure, AppDependencies>> _getAppDependencies() async {
    try {
      AppDependencies dependencies = await _remoteDataSource.getAppDependencies();

      return Right(dependencies);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

}