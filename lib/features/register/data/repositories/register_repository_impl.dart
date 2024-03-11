import 'package:dartz/dartz.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/models/base_model.dart';
import 'package:kafil/core/models/exception.dart';
import 'package:kafil/core/models/failures.dart';
import 'package:kafil/core/network/network_info.dart';
import 'package:kafil/features/register/data/data_sources/remote/register_remote_data_source.dart';
import 'package:kafil/features/register/domain/entities/register_params.dart';
import 'package:kafil/features/register/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final NetworkInfo _networkInfo;
  final RegisterRemoteDataSource _remoteDataSource;

  const RegisterRepositoryImpl({
    required NetworkInfo networkInfo,
    required RegisterRemoteDataSource registerRemoteDataSource,
  })  : _networkInfo = networkInfo,
        _remoteDataSource = registerRemoteDataSource;

  @override
  Future<Either<Failure, BaseModel>> register(RegisterParams params) async {
    if (await _networkInfo.isConnected) {
      return _register(params);
    } else {
      return const Left(ServerFailure(message: kNoConnectionString));
    }
  }

  Future<Either<Failure, BaseModel>> _register(RegisterParams params) async {
    try {
      BaseModel model = await _remoteDataSource.register(params);

      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
