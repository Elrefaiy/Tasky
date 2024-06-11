import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/profile_info.dart';
import '../repositories/get_profile_repo.dart';

class GetProfileUsecase extends UseCase<ProfileInfo, NoParams> {
  final GetProfileInfoRepo getProfileInfoRepo;

  GetProfileUsecase({required this.getProfileInfoRepo});
  @override
  Future<Either<Failure, ProfileInfo>> call(NoParams params) {
    return getProfileInfoRepo.getProfile();
  }
}
