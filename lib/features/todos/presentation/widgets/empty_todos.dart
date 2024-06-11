import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/todos_cubit.dart';

class EmptyTodos extends StatelessWidget {
  const EmptyTodos({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.format_list_bulleted_rounded,
            color: Colors.deepPurple.withOpacity(.2),
            size: 100,
          ),
          BlocBuilder<TodosCubit, TodosState>(
            builder: (context, state) {
              return Text(
                TodosCubit.get(context).emptyLables[
                    TodosCubit.get(context).categoriesCurrentIndex],
                style: Theme.of(context).textTheme.bodySmall,
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
