import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/refresh_token_repo.dart';

class RefreshTokenUsecase extends UseCase<String, NoParams> {
  final RefreshTokenRepo refreshTokenRepo;

  RefreshTokenUsecase({required this.refreshTokenRepo});

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return refreshTokenRepo.refreshToken();
  }
}
