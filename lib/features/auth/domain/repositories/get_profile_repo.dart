import 'package:dartz/dartz.dart';
import '../entities/profile_info.dart';

import '../../../../core/errors/failure.dart';

abstract class GetProfileInfoRepo {
  Future<Either<Failure, ProfileInfo>> getProfile();
}
