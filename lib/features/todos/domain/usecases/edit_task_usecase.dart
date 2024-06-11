import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/edit_task_repo.dart';

class EditTaskUsecase extends UseCase<String, EditTaskParams> {
  final EditTaskRepo editTaskRepo;
  EditTaskUsecase({
    required this.editTaskRepo,
  });
  @override
  Future<Either<Failure, String>> call(EditTaskParams params) {
    return editTaskRepo.editTask(
      params: params,
    );
  }
}
