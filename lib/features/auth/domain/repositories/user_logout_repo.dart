import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';

abstract class UserLogoutRepo {
  Future<Either<Failure, String>> userLogout();
}
