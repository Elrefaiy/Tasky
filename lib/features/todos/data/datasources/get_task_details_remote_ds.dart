import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';

import '../models/todo_model.dart';

abstract class GetTaskDetailsRemoteDS {
  Future<TodoModel> getTaskDetails({required String id});
}

class GetTaskDetailsRemoteDSImpl implements GetTaskDetailsRemoteDS {
  final ApiConsumer apiConsumer;

  GetTaskDetailsRemoteDSImpl({
    required this.apiConsumer,
  });

  @override
  Future<TodoModel> getTaskDetails({required String id}) async {
    final response = await apiConsumer.get(
      path: EndPoints.taskDetails(id: id),
    );
    return TodoModel.fromjson(response);
  }
}
