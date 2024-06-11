import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/error_widget.dart';
import '../cubit/todos_cubit.dart';
import '../widgets/drop_down_button.dart';
import '../widgets/task_datails_widget.dart';

class TaskDetailsScreen extends StatelessWidget {
  final String id;
  const TaskDetailsScreen({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Details',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          TaskDropDownButton(id: id),
        ],
        titleSpacing: 0,
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (state is GetTaskDetailsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetTaskDetailsErrorState) {
            return DefaultErrorWidget(
              refresh: () {
                TodosCubit.get(context).getTaskDetails(id: id);
              },
            );
          } else {
            return TaskDetailsWidget(todo: TodosCubit.get(context).todo);
          }
        },
      ),
    );
  }
}
