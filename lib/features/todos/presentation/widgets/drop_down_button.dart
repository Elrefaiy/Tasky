import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_routes.dart';
import '../../../../core/utils/functions.dart';
import '../cubit/todos_cubit.dart';

class TaskDropDownButton extends StatelessWidget {
  final String id;
  const TaskDropDownButton({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodosCubit, TodosState>(
      listener: (context, state) {
        if (state is DeleteTaskSuccessState) {
          Navigator.maybePop(context);
          TodosCubit.get(context).getTodosLists();
        } else if (state is DeleteTaskErrorState) {
          AppFunctions.showNetworkErrorDialog(context);
        }
      },
      child: PopupMenuButton(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: const Text('Edit'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.editTask,
                  arguments: id,
                );
                TodosCubit.get(context).getTaskDetails(id: id);
              },
            ),
            PopupMenuItem(
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onTap: () {
                TodosCubit.get(context).deleteTask(
                  id: id,
                );
                TodosCubit.get(context).getTodosLists();
              },
            ),
          ];
        },
      ),
    );
  }
}
