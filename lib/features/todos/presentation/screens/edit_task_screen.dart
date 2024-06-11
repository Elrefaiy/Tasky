import 'package:flutter/material.dart';
import '../cubit/todos_cubit.dart';
import '../widgets/edit_task_widget.dart';

class EditTaskScreen extends StatelessWidget {
  final String id;
  const EditTaskScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        titleSpacing: 0,
      ),
      body: EditTaskWidget(
        todo: TodosCubit.get(context).todo,
      ),
    );
  }
}
