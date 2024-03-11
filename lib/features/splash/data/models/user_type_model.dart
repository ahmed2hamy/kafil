import 'package:kafil/features/splash/domain/entities/user_type.dart';

class UserTypeModel extends UserType {
  UserTypeModel({
    super.code,
    super.name,
    super.niceName,
  });

  UserTypeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? json['value'];
    name = json['name'] ?? json['label'];
    niceName = json['nice_name'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['name'] = name;
    map['nice_name'] = niceName;
    return map;
  }
}
