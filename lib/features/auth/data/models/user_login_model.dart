import '../../domain/entities/user_login.dart';

class UserLoginModel extends UserLogin {
  const UserLoginModel({
    required super.id,
    required super.accessToken,
    required super.refreshToken,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      id: json['_id'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
