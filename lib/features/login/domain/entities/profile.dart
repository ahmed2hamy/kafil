import 'package:kafil/features/splash/domain/entities/skill.dart';
import 'package:kafil/features/splash/domain/entities/user_type.dart';

class Profile {
  Profile({
    this.status,
    this.success,
    this.data,
    this.accessToken,
  });

  int? status;
  bool? success;
  ProfileData? data;
  String? accessToken;
}

class ProfileData {
  ProfileData({
    this.id,
    this.firstName,
    this.lastName,
    this.about,
    this.skills,
    this.favoriteSocialMedia,
    this.salary,
    this.email,
    this.birthDate,
    this.gender,
    this.userType,
    this.avatar,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? about;
  List<Skill>? skills;
  List<String>? favoriteSocialMedia;
  int? salary;
  String? email;
  String? birthDate;
  int? gender;
  UserType? userType;
  String? avatar;
}
