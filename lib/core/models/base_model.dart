class BaseModel {
  BaseModel({
    this.status,
    this.success,
    this.data,
    this.accessToken,
  });

  BaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'];
    accessToken = json['access_token'];
  }

  int? status;
  bool? success;
  dynamic data;
  String? accessToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['success'] = success;
    map['data'] = data;
    return map;
  }
}
