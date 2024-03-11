import 'dart:io';

import 'package:dio/dio.dart';
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
      FormData avatarFormData = await _uploadFile(params.avatar);

      Map<String, dynamic> json = await _networkClient.post(
        Apis.register,
        data: {
          'first_name': params.firstName,
          'last_name': params.lastName,
          'about': params.about,
          'tags': params.skills,
          'favorite_social_media': params.favoriteSocialMedia,
          'salary': params.salary,
          'password': params.password,
          'password_confirmation': params.passwordConfirmation,
          'email': params.email,
          'birth_date': params.birthDate,
          'gender': params.gender,
          'type': params.userType,
          'avatar': avatarFormData,
        },
      );

      return BaseModel.fromJson(json);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<FormData> _uploadFile(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    return formData;
  }
}
