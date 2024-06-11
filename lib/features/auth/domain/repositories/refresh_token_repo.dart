import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class RefreshTokenRepo {
  Future<Either<Failure, String>> refreshToken();
}
