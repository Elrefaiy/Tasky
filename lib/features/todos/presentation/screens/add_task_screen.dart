import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_routes.dart';
import '../../../../core/utils/functions.dart';
import '../widgets/date_picker.dart';
import '../widgets/dotted_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/def_button.dart';
import '../../../../core/widgets/def_dropdown_menue.dart';
import '../../../../core/widgets/def_input_field.dart';
import '../cubit/todos_cubit.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = TodosCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Task',
          style: TextStyle(fontSize: 18),
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const DottedButton(),
                const SizedBox(height: 15),
                Text(
                  'Task Title',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 10),
                DefaultInputField(
                  hintText: 'Enter title here ...',
                  controller: cubit.titleController,
                ),
                const SizedBox(height: 15),
                Text(
                  'Task Description',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 10),
                DefaultInputField(
                  height: 170,
                  hintText: 'Enter description here ...',
                  controller: cubit.descController,
                  maxlines: 6,
                  textInputType: TextInputType.multiline,
                ),
                const SizedBox(height: 15),
                Text(
                  'Priority',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 10),
                BlocBuilder<TodosCubit, TodosState>(
                  builder: (context, state) {
                    return DefaultDropDownMenue(
                      items: cubit.priorityItems,
                      value: cubit.priority,
                      hint: 'Choose Priority',
                      color: AppColors.secondaryColor,
                      iconColor: Colors.deepPurple,
                      withIcon: true,
                      onChanged: (value) {
                        cubit.changePriority(value.toString());
                      },
                    );
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  'Due Date',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 10),
                const DatePickerField(),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<TodosCubit, TodosState>(
                  listener: (context, state) {
                    if (state is UploadImageLoadingState ||
                        state is CreateTaskLoadingState) {
                      AppFunctions.showLoading(context);
                    } else if (state is CreateTaskSuccessState) {
                      Navigator.pop(context);
                      cubit.getTodosLists();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.home,
                        (route) => false,
                      );
                    } else if (state is UploadImageErrorState) {
                      Navigator.pop(context);
                      AppFunctions.showNetworkErrorDialog(
                        context,
                        largeFile: true,
                      );
                    } else if (state is NoInternetConnectionState) {
                      Navigator.pop(context);
                      AppFunctions.showNetworkErrorDialog(
                        context,
                      );
                    }
                  },
                  builder: (context, state) {
                    return DefaultButton(
                      onPressed: () async {
                        if (cubit.formKey.currentState!.validate() &&
                            cubit.taskImage != null) {
                          await cubit.uploadImage();
                          if (cubit.uploadedImagePath != null) {
                            await cubit.createTask();
                          }
                        } else if (cubit.taskImage == null) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const SimpleDialog(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 40,
                                ),
                                children: [
                                  Center(
                                    child: Text(
                                      'complete your task info\nplease!',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      lable: 'Add Task',
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
