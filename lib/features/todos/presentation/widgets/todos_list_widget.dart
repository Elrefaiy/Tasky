import 'package:flutter/material.dart';
import '../../domain/entities/todo.dart';
import 'empty_todos.dart';
import 'todo_item.dart';

class TodosListWidget extends StatelessWidget {
  final List<Todo> todos;

  const TodosListWidget({
    required this.todos,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Expanded(
        child: EmptyTodos(),
      );
    } else {
      return Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 40,
          ),
          itemBuilder: (context, index) {
            return TodoItem(
              todo: todos[index],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 20);
          },
          itemCount: todos.length,
        ),
      );
    }
  }
}
