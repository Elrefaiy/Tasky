import 'package:dartz/dartz.dart';
import '../entities/user_login.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';

abstract class UserLoginRepo {
  Future<Either<Failure, UserLogin>> userLogin({
    required UserLoginParams params,
  });
}
