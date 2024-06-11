import '../../domain/entities/profile_info.dart';

class ProfileInfoModel extends ProfileInfo {
  const ProfileInfoModel({
    required super.id,
    required super.displayName,
    required super.username,
    required super.roles,
    required super.active,
    required super.experienceYears,
    required super.address,
    required super.level,
    required super.createdAt,
    required super.updatedAt,
    required super.v,
  });

  factory ProfileInfoModel.fromJson(Map<String, dynamic> json) {
    return ProfileInfoModel(
      id: json['_id'],
      displayName: json['displayName'],
      username: json['username'],
      roles: json['roles'],
      active: json['active'],
      experienceYears: json['experienceYears'],
      address: json['address'],
      level: json['level'],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      v: json['__v'],
    );
  }
}
