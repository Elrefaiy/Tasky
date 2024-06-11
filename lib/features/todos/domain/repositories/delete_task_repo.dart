import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';

abstract class DeleteTaskRepo {
  Future<Either<Failure, String>> deleteTask({
    required String id,
  });
}
