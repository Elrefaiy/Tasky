import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/delete_task_repo.dart';

class DeleteTaskUsecase extends UseCase<String, String> {
  final DeleteTaskRepo deleteTaskRepo;

  DeleteTaskUsecase({required this.deleteTaskRepo});

  @override
  Future<Either<Failure, String>> call(String params) {
    return deleteTaskRepo.deleteTask(id: params);
  }
}
