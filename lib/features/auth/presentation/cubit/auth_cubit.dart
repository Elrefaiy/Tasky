import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/refresh_token_usecase.dart';
import '../../domain/usecases/user_logout_usecase.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/profile_info.dart';
import '../../domain/entities/user_register.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/user_register_usecase.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/user_login.dart';
import '../../domain/usecases/user_login_usecase.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserLoginUsecase userLoginUsecase;
  final UserRegisterUsecase userRegisterUsecase;
  final GetProfileUsecase getProfileUsecase;
  final RefreshTokenUsecase refreshTokenUsecase;
  final UserLogoutUsecase userLogoutUsecase;
  AuthCubit({
    required this.userLoginUsecase,
    required this.userRegisterUsecase,
    required this.getProfileUsecase,
    required this.refreshTokenUsecase,
    required this.userLogoutUsecase,
  }) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  final List<String> profileData = [
    'NAME',
    'PHONE',
    'LEVEL',
    'YEARS OF EXPERIENCE',
    'LOCATION',
  ];

  final List<DropdownMenuItem<String>> levelItems =
      const <DropdownMenuItem<String>>[
    DropdownMenuItem(
      value: 'fresh',
      child: Text(
        'Fresh',
      ),
    ),
    DropdownMenuItem(
      value: 'junior',
      child: Text(
        'Junior',
      ),
    ),
    DropdownMenuItem(
      value: 'midLevel',
      child: Text(
        'Mid Level',
      ),
    ),
    DropdownMenuItem(
      value: 'senior',
      child: Text(
        'Senior',
      ),
    ),
  ];

  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final loginPhoneController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final experienceController = TextEditingController();
  final addressController = TextEditingController();
  final registerPasswordController = TextEditingController();

  bool isHidden = true;
  void changePasswordVisability() {
    emit(AuthInitial());
    isHidden = !isHidden;
    emit(ChangePasswordVisabilityState());
  }

  String countryCode = '+20';
  void setCountryCode(String code) {
    countryCode = code;
  }

  Future<void> userLogin() async {
    emit(UserLoginLoadingState());
    final params = UserLoginParams(
      phone: '$countryCode${loginPhoneController.text}',
      password: loginPasswordController.text,
    );
    final response = await userLoginUsecase.call(params);
    response.fold(
      (failure) {
        emit(const UserLoginErrorState(AppStrings.loginErrorMsg));
      },
      (userLogin) {
        emit(UserLoginSuccessState(userLogin));
      },
    );
  }

  String? level;
  void setLevel(String level) {
    emit(AuthInitial());
    this.level = level;
    emit(ChangeExperienceLevelState());
  }

  Future<void> userRegister() async {
    emit(UserRegisterLoadingState());
    final params = UserRegisterParams(
      displayName: nameController.text,
      phone: '$countryCode${registerPhoneController.text}',
      password: registerPasswordController.text,
      address: addressController.text,
      experienceYears: int.tryParse(experienceController.text) ?? 0,
      level: level ?? 'fresh',
    );
    final response = await userRegisterUsecase.call(params);
    response.fold(
      (failure) {
        emit(const UserRegisterErrorState(AppStrings.registerErrorMsg));
      },
      (userRegister) {
        emit(UserRegisterSuccessState(userRegister));
      },
    );
  }

  Future<void> getProfileInfo() async {
    emit(GetProfileInfoLoadingState());
    final response = await getProfileUsecase(NoParams());
    response.fold(
      (failure) {
        emit(const GetProfileInfoErrorState(AppStrings.registerErrorMsg));
      },
      (profileInfo) {
        emit(GetProfileInfoSuccessState(profileInfo));
      },
    );
  }

  Future<void> refreshToken() async {
    final response = await refreshTokenUsecase(NoParams());
    response.fold(
      (failure) {
        emit(const RefreshTokenErrorState('Refresh Token Faild'));
      },
      (accessToken) {},
    );
  }

  Future<void> userLogout() async {
    final response = await userLogoutUsecase(NoParams());
    response.fold(
      (failure) {
        emit(const UserLogoutErrorState('Failed to Logout'));
      },
      (success) {
        emit(UserLogoutSuccessState());
      },
    );
  }
}
