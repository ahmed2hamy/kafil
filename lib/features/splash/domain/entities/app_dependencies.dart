import 'package:kafil/features/splash/domain/entities/skill.dart';
import 'package:kafil/features/splash/domain/entities/social_media.dart';
import 'package:kafil/features/splash/domain/entities/user_type.dart';

class AppDependencies {
  AppDependencies({
    this.userTypes,
    this.skills,
    this.socialMedia,
  });

  List<UserType>? userTypes;
  List<Skill>? skills;
  List<SocialMedia>? socialMedia;
}
