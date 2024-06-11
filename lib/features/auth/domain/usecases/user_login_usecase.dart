import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_login.dart';
import '../repositories/user_login_repo.dart';

class UserLoginUsecase extends UseCase<UserLogin, UserLoginParams> {
  final UserLoginRepo userLoginRepo;

  UserLoginUsecase({
    required this.userLoginRepo,
  });
  @override
  Future<Either<Failure, UserLogin>> call(params) {
    return userLoginRepo.userLogin(params: params);
  }
}
