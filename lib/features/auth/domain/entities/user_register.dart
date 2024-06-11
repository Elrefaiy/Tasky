import 'package:equatable/equatable.dart';

class UserRegister extends Equatable {
  final String id;
  final String displayName;
  final String accessToken;
  final String refreshToken;

  const UserRegister({
    required this.id,
    required this.displayName,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [id, displayName, accessToken, refreshToken];
}
