import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_register.dart';

import '../../../../core/errors/failure.dart';

abstract class UserRegisterRepo {
  Future<Either<Failure, UserRegister>> userRegister({
    required UserRegisterParams params,
  });
}
