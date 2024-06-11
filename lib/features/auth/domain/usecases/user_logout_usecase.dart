import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/user_logout_repo.dart';

class UserLogoutUsecase extends UseCase<String, NoParams> {
  final UserLogoutRepo userLogoutRepo;
  UserLogoutUsecase({
    required this.userLogoutRepo,
  });

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return userLogoutRepo.userLogout();
  }
}
