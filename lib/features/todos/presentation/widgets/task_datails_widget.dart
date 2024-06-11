import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../cubit/todos_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/def_dropdown_menue.dart';
import '../../domain/entities/todo.dart';

class TaskDetailsWidget extends StatelessWidget {
  final Todo todo;
  const TaskDetailsWidget({
    required this.todo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage(
              todo.image,
            ),
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              todo.title,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              todo.desc,
              maxLines: 40,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 10),
          Container(
              height: 50,
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.secondaryColor,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'End Date',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        todo.updatedAt.toString().substring(0, 10),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    FontAwesomeIcons.solidCalendarDays,
                    color: Colors.deepPurple,
                    size: 22,
                  ),
                ],
              )),
          BlocConsumer<TodosCubit, TodosState>(
            listener: (context, state) {
              if (state is EditTaskSuccessState) {
                TodosCubit.get(context).getTodosLists();
              }
            },
            builder: (context, state) {
              return DefaultDropDownMenue(
                value: todo.status,
                items: TodosCubit.get(context).statusItems,
                hint: '',
                onChanged: (value) async {
                  await TodosCubit.get(context).editTask(
                    data: {
                      'status': value.toString(),
                    },
                  );
                },
                margin: const EdgeInsets.symmetric(horizontal: 20),
                color: AppColors.secondaryColor,
                iconColor: Colors.deepPurple,
              );
            },
          ),
          const SizedBox(height: 10),
          BlocBuilder<TodosCubit, TodosState>(
            builder: (context, state) {
              return DefaultDropDownMenue(
                value: todo.priority,
                items: TodosCubit.get(context).priorityItems,
                hint: '',
                onChanged: (value) async {
                  await TodosCubit.get(context).editTask(
                    data: {
                      'priority': value.toString(),
                    },
                  );
                },
                margin: const EdgeInsets.symmetric(horizontal: 20),
                color: AppColors.secondaryColor,
                iconColor: Colors.deepPurple,
                withIcon: true,
              );
            },
          ),
          Align(
            alignment: Alignment.center,
            child: QrImageView(
              data: todo.id,
              version: QrVersions.auto,
              padding: const EdgeInsets.all(
                30,
              ),
              size: 400,
            ),
          ),
        ],
      ),
    );
  }
}
