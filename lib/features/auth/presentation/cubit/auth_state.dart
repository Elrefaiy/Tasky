part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class ChangePasswordVisabilityState extends AuthState {}

class ChangeExperienceLevelState extends AuthState {}

class UserLoginLoadingState extends AuthState {}

class UserLoginSuccessState extends AuthState {
  final UserLogin userLogin;
  const UserLoginSuccessState(this.userLogin);

  @override
  List<Object> get props => [userLogin];
}

class UserLoginErrorState extends AuthState {
  final String? errorMsg;

  const UserLoginErrorState([this.errorMsg]);
}

class UserRegisterLoadingState extends AuthState {}

class UserRegisterSuccessState extends AuthState {
  final UserRegister userRegister;
  const UserRegisterSuccessState(this.userRegister);

  @override
  List<Object> get props => [userRegister];
}

class UserRegisterErrorState extends AuthState {
  final String? errorMsg;

  const UserRegisterErrorState([this.errorMsg]);
}

class GetProfileInfoLoadingState extends AuthState {}

class GetProfileInfoSuccessState extends AuthState {
  final ProfileInfo profileInfo;
  const GetProfileInfoSuccessState(this.profileInfo);

  @override
  List<Object> get props => [profileInfo];
}

class GetProfileInfoErrorState extends AuthState {
  final String? errorMsg;

  const GetProfileInfoErrorState([this.errorMsg]);
}

class RefreshTokenErrorState extends AuthState {
  final String? errorMsg;

  const RefreshTokenErrorState([this.errorMsg]);
}

class UserLogoutSuccessState extends AuthState {}

class UserLogoutErrorState extends AuthState {
  final String? errorMsg;

  const UserLogoutErrorState([this.errorMsg]);
}
