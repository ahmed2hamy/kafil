import 'package:kafil/features/splash/domain/entities/social_media.dart';

class SocialMediaModel extends SocialMedia {
  SocialMediaModel({
    super.value,
    super.label,
  });

  SocialMediaModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['label'] = label;
    return map;
  }
}
