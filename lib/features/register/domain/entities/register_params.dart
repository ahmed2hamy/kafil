import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kafil/features/register/presentation/manager/register_provider.dart';
import 'package:kafil/features/splash/domain/entities/app_dependencies.dart';

class RegisterParams extends Equatable {
  final FormData requestFormData;

  const RegisterParams({required this.requestFormData});

  @override
  List<Object?> get props => [requestFormData];
}

class RegisterRequestBody {
  static Future<FormData> toMap(
      AppDependencies appDependencies, RegisterProvider provider) async {
    List<int> skills = provider.skills
            ?.map((e) => appDependencies.skills
                ?.firstWhere((skill) => skill.name == e)
                .id)
            .whereType<int>()
            .toList() ??
        [];

    String firstName = provider.firstName ?? '';
    String lastName = provider.lastName ?? '';
    String about = provider.about ?? '';
    List<String> favoriteSocialMediaList = provider.favoriteSocialMediaList;
    int salary = provider.salary ?? 100;
    String password = provider.password ?? '';
    String passwordConfirmation = provider.passwordConfirmation ?? '';
    String email = provider.email ?? '';
    String birthDate = provider.birthDate ?? '';
    int? gender = provider.gender;
    int userType = provider.userType ?? 1;
    File? avatar = provider.avatar;

    var formDataMap = {
      'first_name': firstName,
      'last_name': lastName,
      'about': about,
      'salary': salary.toString(),
      'password': password,
      'password_confirmation': passwordConfirmation,
      'email': email,
      'birth_date': birthDate,
      'gender': gender.toString(),
      'type': userType.toString(),
    };

    skills.asMap().forEach((i, skillId) {
      formDataMap['tags[$i]'] = skillId.toString();
    });

    favoriteSocialMediaList.asMap().forEach((i, media) {
      formDataMap['favorite_social_media[$i]'] = media;
    });

    FormData formData = FormData.fromMap(formDataMap);

    if (avatar != null && await avatar.exists()) {
      formData.files.add(MapEntry(
        "avatar",
        await MultipartFile.fromFile(avatar.path,
            filename: avatar.path.split(Platform.pathSeparator).last),
      ));
    }

    return formData;
  }
}
