import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/todo.dart';
import 'dotted_button.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/def_button.dart';
import '../../../../core/widgets/def_input_field.dart';
import '../cubit/todos_cubit.dart';

class EditTaskWidget extends StatelessWidget {
  final Todo todo;
  const EditTaskWidget({required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = TodosCubit.get(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: cubit.editFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              const DottedButton(),
              const SizedBox(height: 15),
              Text(
                'Task Title',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              DefaultInputField(
                hintText: 'Enter title here ...',
                controller: cubit.editTitleController,
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
                controller: cubit.editDescController,
                maxlines: 6,
                textInputType: TextInputType.multiline,
              ),
              const SizedBox(height: 20),
              BlocConsumer<TodosCubit, TodosState>(
                listener: (context, state) async {
                  if (state is UploadImageLoadingState ||
                      state is EditTaskLoadingState) {
                    AppFunctions.showLoading(context);
                  } else if (state is EditTaskSuccessState) {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.home,
                      (route) => false,
                    );
                    await cubit.getTodosLists();
                  } else if (state is EditTaskErrorState) {
                    Navigator.pop(context);
                    AppFunctions.showNetworkErrorDialog(context);
                  } else if (state is UploadImageErrorState) {
                    Navigator.pop(context);
                    AppFunctions.showNetworkErrorDialog(
                      context,
                      largeFile: true,
                    );
                  }
                },
                builder: (context, state) {
                  return DefaultButton(
                    onPressed: () async {
                      if (cubit.editFormKey.currentState!.validate()) {
                        if (cubit.taskImage != null) {
                          await cubit.uploadImage();
                        } else {
                          await cubit.editTask(
                            data: {
                              'title': cubit.editTitleController.text,
                              'desc': cubit.editDescController.text,
                            },
                          );
                        }
                        if (cubit.uploadedImagePath != null) {
                          await cubit.editTask(
                            data: {
                              'title': cubit.editTitleController.text,
                              'desc': cubit.editDescController.text,
                              'image':
                                  '${AppStrings.imageBase}${cubit.uploadedImagePath}',
                            },
                          );
                        }
                      }
                    },
                    lable: 'Save',
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
