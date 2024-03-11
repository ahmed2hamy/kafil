import 'package:dartz/dartz.dart';
import 'package:kafil/core/models/exception.dart';
import 'package:kafil/core/models/failures.dart';
import 'package:kafil/core/network/network_info.dart';
import 'package:kafil/core/use_case/use_case.dart';
import 'package:kafil/features/login/data/data_sources/local/login_local_data_source.dart';
import 'package:kafil/features/login/data/data_sources/remote/login_remote_data_source.dart';
import 'package:kafil/features/login/domain/entities/profile.dart';
import 'package:kafil/features/login/domain/repositories/login_repository.dart';
import 'package:kafil/features/login/domain/use_cases/login_use_case.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetworkInfo _networkInfo;
  final LoginRemoteDataSource _remoteDataSource;
  final LoginLocalDataSource _localDataSource;

  LoginRepositoryImpl({
    required NetworkInfo networkInfo,
    required LoginRemoteDataSource loginRemoteDataSource,
    required LoginLocalDataSource loginLocalDataSource,
  })  : _networkInfo = networkInfo,
        _remoteDataSource = loginRemoteDataSource,
        _localDataSource = loginLocalDataSource;

  @override
  Future<Either<Failure, Profile>> login(LoginParams params) async {
    if (await _networkInfo.isConnected) {
      return _loginRemotely(params);
    } else {
      return const Left(ServerFailure(message: 'No internet connection.'));
    }
  }

  Future<Either<Failure, Profile>> _loginRemotely(LoginParams params) async {
    try {
      final Profile profile = await _remoteDataSource.login(params);
      if (params.rememberMe) {
        await _localDataSource.saveLoginData(profile);
      }
      return Right(profile);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Profile?>> autoLogin(NoParams params) async {
    try {
      Profile? profile;
      final localDataExists = await _localDataSource.hasLoginData();
      if (localDataExists) {
        profile = await _localDataSource.getLoginData();
      }
      return Right(profile);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> logout(NoParams noParams) async {
    try {
      await _localDataSource.clearLoginData();

      return const Right(true);
    } on CacheException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
