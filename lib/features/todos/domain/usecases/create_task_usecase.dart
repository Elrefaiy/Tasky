import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/create_task_repo.dart';

import '../entities/todo.dart';

class CreateTaskUseCase extends UseCase<Todo, CreateTaskParams> {
  final CreateTaskRepo createTaskRepo;

  CreateTaskUseCase({
    required this.createTaskRepo,
  });

  @override
  Future<Either<Failure, Todo>> call(CreateTaskParams params) {
    return createTaskRepo.createTask(params: params);
  }
}
