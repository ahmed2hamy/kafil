import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/config/user_config.dart';
import 'package:kafil/core/models/exception.dart';
import 'package:kafil/core/network/network_client.dart';
import 'package:kafil/features/login/data/models/profile_model.dart';
import 'package:kafil/features/login/domain/entities/profile.dart';
import 'package:kafil/features/login/domain/use_cases/login_use_case.dart';

abstract class LoginRemoteDataSource {
  Future<Profile> login(LoginParams params);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final NetworkClient _networkClient;

  const LoginRemoteDataSourceImpl({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;

  @override
  Future<Profile> login(LoginParams params) async {
    try {
      Map<String, dynamic> json = await _networkClient.post(
        Apis.login,
        data: {
          'email': params.email,
          'password': params.password,
        },
      );

      ProfileModel profile = ProfileModel.fromJson(json);

      UserConfig.setAccessToken(profile.accessToken);

      return profile;
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
