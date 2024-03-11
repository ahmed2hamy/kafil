import 'package:kafil/features/splash/data/models/skill_model.dart';
import 'package:kafil/features/splash/data/models/social_media_model.dart';
import 'package:kafil/features/splash/data/models/user_type_model.dart';
import 'package:kafil/features/splash/domain/entities/app_dependencies.dart';

class AppDependenciesModel extends AppDependencies {
  AppDependenciesModel({
    super.userTypes,
    super.skills,
    super.socialMedia,
  });

  AppDependenciesModel.fromJson(Map<String, dynamic> json) {
    if (json['types'] != null) {
      userTypes = [];
      json['types'].forEach((v) {
        userTypes?.add(UserTypeModel.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      skills = [];
      json['tags'].forEach((v) {
        skills?.add(SkillModel.fromJson(v));
      });
    }
    if (json['social_media'] != null) {
      socialMedia = [];
      json['social_media'].forEach((v) {
        socialMedia?.add(SocialMediaModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (userTypes != null) {
      map['types'] = userTypes
          ?.map((v) => UserTypeModel(
                code: v.code,
                name: v.name,
                niceName: v.niceName,
              ).toJson())
          .toList();
    }
    if (skills != null) {
      map['tags'] = skills
          ?.map((v) => SkillModel(
                id: v.id,
                name: v.name,
              ).toJson())
          .toList();
    }
    if (socialMedia != null) {
      map['social_media'] = socialMedia
          ?.map((v) => SocialMediaModel(
                label: v.label,
                value: v.value,
              ).toJson())
          .toList();
    }
    return map;
  }
}
