import 'package:equatable/equatable.dart';

class UserLogin extends Equatable {
  final String id;
  final String accessToken;
  final String refreshToken;

  const UserLogin({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [id, accessToken, refreshToken];
}
