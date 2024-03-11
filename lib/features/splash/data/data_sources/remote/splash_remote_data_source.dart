import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/models/base_model.dart';
import 'package:kafil/core/models/exception.dart';
import 'package:kafil/core/network/network_client.dart';
import 'package:kafil/features/splash/data/models/app_dependencies_model.dart';
import 'package:kafil/features/splash/domain/entities/app_dependencies.dart';

abstract class SplashRemoteDataSource {
  Future<AppDependencies> getAppDependencies();
}

class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  final NetworkClient _networkClient;

  const SplashRemoteDataSourceImpl({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;

  @override
  Future<AppDependencies> getAppDependencies() async {
    try {
      Map<String, dynamic> json = await _networkClient.get(Apis.dependencies);

      return AppDependenciesModel.fromJson(
        BaseModel.fromJson(json).data,
      );
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
