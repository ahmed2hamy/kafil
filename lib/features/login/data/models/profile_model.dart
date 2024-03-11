import 'package:kafil/features/login/domain/entities/profile.dart';
import 'package:kafil/features/splash/data/models/skill_model.dart';
import 'package:kafil/features/splash/data/models/user_type_model.dart';

class ProfileModel extends Profile {
  ProfileModel({
    super.status,
    super.success,
    super.data,
    super.accessToken,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data =
        json['data'] != null ? ProfileDataModel.fromJson(json['data']) : null;
    accessToken = json['access_token'];
  }

  ProfileModel.fromEntity(Profile profile) {
    status = profile.status;
    success = profile.success;
    data = profile.data;
    accessToken = profile.accessToken;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['success'] = success;
    if (data != null) {
      map['data'] = ProfileDataModel(
        id: data?.id,
        firstName: data?.firstName,
        lastName: data?.lastName,
        about: data?.about,
        skills: data?.skills,
        favoriteSocialMedia: data?.favoriteSocialMedia,
        salary: data?.salary,
        email: data?.email,
        birthDate: data?.birthDate,
        gender: data?.gender,
        userType: data?.userType,
        avatar: data?.avatar,
      ).toJson();
    }
    map['access_token'] = accessToken;
    return map;
  }
}

class ProfileDataModel extends ProfileData {
  ProfileDataModel({
    super.id,
    super.firstName,
    super.lastName,
    super.about,
    super.skills,
    super.favoriteSocialMedia,
    super.salary,
    super.email,
    super.birthDate,
    super.gender,
    super.userType,
    super.avatar,
  });

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    about = json['about'];
    if (json['tags'] != null) {
      skills = [];
      json['tags'].forEach((v) {
        skills?.add(SkillModel.fromJson(v));
      });
    }
    favoriteSocialMedia = json['favorite_social_media'] != null
        ? json['favorite_social_media'].cast<String>()
        : [];
    salary = json['salary'];
    email = json['email'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    userType =
        json['type'] != null ? UserTypeModel.fromJson(json['type']) : null;
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['about'] = about;
    if (skills != null) {
      map['tags'] = skills
          ?.map((v) => SkillModel(
                id: v.id,
                name: v.name,
              ).toJson())
          .toList();
    }
    map['favorite_social_media'] = favoriteSocialMedia;
    map['salary'] = salary;
    map['email'] = email;
    map['birth_date'] = birthDate;
    map['gender'] = gender;
    if (userType != null) {
      map['type'] = UserTypeModel(
        code: userType?.code,
        name: userType?.name,
        niceName: userType?.niceName,
      ).toJson();
    }
    map['avatar'] = avatar;
    return map;
  }
}
