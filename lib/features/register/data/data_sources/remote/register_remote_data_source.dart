import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/models/base_model.dart';
import 'package:kafil/core/models/exception.dart';
import 'package:kafil/core/network/network_client.dart';
import 'package:kafil/features/register/domain/entities/register_params.dart';

abstract class RegisterRemoteDataSource {
  Future<BaseModel> register(RegisterParams params);
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final NetworkClient _networkClient;

  const RegisterRemoteDataSourceImpl({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;

  @override
  Future<BaseModel> register(RegisterParams params) async {
    try {
      Map<String, dynamic> json = await _networkClient.post(
        Apis.register,
        data: params.requestFormData,
        contentType: 'multipart/form-data',
      );

      return BaseModel.fromJson(json);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
