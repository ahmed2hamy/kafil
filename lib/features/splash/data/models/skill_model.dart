import 'package:kafil/features/splash/domain/entities/skill.dart';

class SkillModel extends Skill {
  SkillModel({
    super.id,
    super.name,
  });

  SkillModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? json['value'];
    name = json['name'] ?? json['label'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
