import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_register.dart';
import '../repositories/user_register_repo.dart';

class UserRegisterUsecase extends UseCase<UserRegister, UserRegisterParams> {
  final UserRegisterRepo userRegisterRepo;
  UserRegisterUsecase({
    required this.userRegisterRepo,
  });
  @override
  Future<Either<Failure, UserRegister>> call(UserRegisterParams params) {
    return userRegisterRepo.userRegister(params: params);
  }
}
