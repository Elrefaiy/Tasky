import '../../domain/entities/user_register.dart';

class UserRegisterModel extends UserRegister {
  const UserRegisterModel({
    required super.id,
    required super.displayName,
    required super.accessToken,
    required super.refreshToken,
  });

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterModel(
      id: json['_id'],
      displayName: json['displayName'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
