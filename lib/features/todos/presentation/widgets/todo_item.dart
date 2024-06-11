import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'drop_down_button.dart';
import '../../../../config/app_routes.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/todo.dart';
import '../cubit/todos_cubit.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({
    required this.todo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        TodosCubit.get(context).getTaskDetails(id: todo.id);
        Navigator.pushNamed(
          context,
          Routes.taskDetails,
          arguments: todo.id,
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: NetworkImage(
                todo.image,
              ),
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        todo.title,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                        color: statusColor(todo.status).withOpacity(.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      child: Text(
                        todo.status.firstToUpperCase(),
                        style: TextStyle(
                          color: statusColor(todo.status),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  todo.desc,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.flag,
                      color: priorityColor(todo.priority),
                      size: 14,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      todo.priority.firstToUpperCase(),
                      style: TextStyle(
                        color: priorityColor(todo.priority),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      todo.createdAt.toString().substring(0, 10),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          TaskDropDownButton(id: todo.id),
        ],
      ),
    );
  }

  Color statusColor(String status) {
    switch (status) {
      case 'inProgress':
        return Colors.deepPurple;
      case 'waiting':
        return Colors.deepOrange;
      default:
        return Colors.blueAccent;
    }
  }

  Color priorityColor(String priority) {
    switch (priority) {
      case 'medium':
        return Colors.deepPurple;
      case 'high':
        return Colors.deepOrange;
      default:
        return Colors.blueAccent;
    }
  }
}
