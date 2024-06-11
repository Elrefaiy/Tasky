import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/usecases/create_task_usecase.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/edit_task_usecase.dart';
import '../../domain/usecases/upload_image_usecase.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_task_details_usecase.dart';
import '../../domain/usecases/get_todos_list_usecase.dart';

import '../../domain/entities/todo.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final GetTodosListUsecase getTodosListUsecase;
  final GetTaskDetailsUsecase getTaskDetailsUsecase;
  final UploadImageUsecase uploadImageUsecase;
  final CreateTaskUseCase createTaskUseCase;
  final DeleteTaskUsecase deleteTaskUsecase;
  final EditTaskUsecase editTaskUsecase;
  TodosCubit({
    required this.getTodosListUsecase,
    required this.getTaskDetailsUsecase,
    required this.uploadImageUsecase,
    required this.createTaskUseCase,
    required this.deleteTaskUsecase,
    required this.editTaskUsecase,
  }) : super(TodosInitial());
  static TodosCubit get(context) => BlocProvider.of(context);

  final List<String> lables = <String>[
    'All',
    'In Progress',
    'Waiting',
    'Finished',
  ];

  final List<String> emptyLables = <String>[
    'your todos is empty',
    'no task is in progress',
    'no task is waiting',
    'no task is finished yet',
  ];

  final List<DropdownMenuItem<String>> priorityItems =
      const <DropdownMenuItem<String>>[
    DropdownMenuItem(
      value: 'low',
      child: Text(
        'Low Priority',
      ),
    ),
    DropdownMenuItem(
      value: 'medium',
      child: Text(
        'Medium Priority',
      ),
    ),
    DropdownMenuItem(
      value: 'high',
      child: Text(
        'High Priority',
      ),
    ),
  ];

  final List<DropdownMenuItem<String>> statusItems =
      const <DropdownMenuItem<String>>[
    DropdownMenuItem(
      value: 'waiting',
      child: Text(
        'Waiting',
      ),
    ),
    DropdownMenuItem(
      value: 'inProgress',
      child: Text(
        'In Progress',
      ),
    ),
    DropdownMenuItem(
      value: 'finished',
      child: Text(
        'Finished',
      ),
    ),
  ];

  String priority = 'medium';
  void changePriority(String priority) {
    emit(TodosInitial());
    this.priority = priority;
    emit(ChangeTaskPriorityState());
  }

  String status = 'waiting';
  void changeStatus(String status) {
    emit(TodosInitial());
    this.status = status;
    emit(ChangeStatusState());
  }

  int categoriesCurrentIndex = 0;
  void changeCategoryIndex(int index) {
    emit(TodosInitial());
    categoriesCurrentIndex = index;
    emit(ChangeCategoriesCurrentIndexState());
  }

  List<Todo> all = [];
  List<Todo> inProgress = [];
  List<Todo> waiting = [];
  List<Todo> finished = [];

  Future<void> getTodosLists() async {
    emit(GetTodosListLoadingState());
    all = [];
    inProgress = [];
    waiting = [];
    finished = [];
    final response = await getTodosListUsecase.call(NoParams());
    response.fold(
      (failure) {
        emit(GetTodosListErrorState());
      },
      (todosList) {
        for (var element in todosList) {
          all.add(element);
          switch (element.status) {
            case 'inProgress':
              inProgress.add(element);
              break;
            case 'waiting':
              waiting.add(element);
              break;
            case 'finished':
              finished.add(element);
              break;
            default:
          }
        }
        emit(GetTodosListSuccessState());
      },
    );
  }

  Todo todo = Todo(
    id: '',
    image: '',
    title: '',
    desc: '',
    priority: '',
    status: '',
    user: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    v: 0,
  );
  Future<void> getTaskDetails({required String id}) async {
    emit(GetTaskDetailsLoadingState());
    final response = await getTaskDetailsUsecase.call(id);
    response.fold(
      (failure) {
        emit(GetTaskDetailsErrorState());
      },
      (taskDetails) {
        todo = taskDetails;
        editTitleController.text = taskDetails.title;
        editDescController.text = taskDetails.desc;
        emit(GetTaskDetailsSuccessState(todo: taskDetails));
      },
    );
  }

  File? taskImage;
  Future<void> pickImage({required ImageSource imageSource}) async {
    final pickedImage = await ImagePicker().pickImage(
      source: imageSource,
    );
    if (pickedImage != null) {
      taskImage = File(pickedImage.path);
      emit(PickImageSuccessState());
    }
  }

  Future<void> removeImage() async {
    taskImage = null;
    emit(RemoveImageSuccessState());
  }

  String? uploadedImagePath;
  Future<void> uploadImage() async {
    emit(UploadImageLoadingState());
    if (taskImage != null) {
      final response = await uploadImageUsecase.call(taskImage!);
      response.fold(
        (failure) {
          if (failure.code == 413) {
            emit(UploadImageErrorState());
          } else {
            emit(NoInternetConnectionState());
          }
        },
        (imagePath) {
          uploadedImagePath = imagePath;
          emit(UploadImageSuccessState());
        },
      );
    }
  }

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final dateController = TextEditingController();

  Future<void> createTask() async {
    emit(CreateTaskLoadingState());
    final params = CreateTaskParams(
      image: '${AppStrings.imageBase}$uploadedImagePath',
      title: titleController.text,
      desc: descController.text,
      priority: priority,
      dueDate: dateController.text,
    );
    final response = await createTaskUseCase.call(params);
    response.fold(
      (failure) {
        emit(CreateTaskErrorState());
      },
      (todo) {
        taskImage = null;
        uploadedImagePath = null;
        titleController.text = '';
        descController.text = '';
        priority = 'medium';
        dateController.text = '';

        emit(CreateTaskSuccessState());
      },
    );
  }

  Future<void> deleteTask({required String id}) async {
    emit(DeleteTaskLoadingState());
    all = [];
    inProgress = [];
    waiting = [];
    finished = [];
    final response = await deleteTaskUsecase(id);
    response.fold(
      (failure) {
        emit(DeleteTaskErrorState());
      },
      (success) async {
        emit(DeleteTaskSuccessState());
      },
    );
  }

  final editFormKey = GlobalKey<FormState>();
  final editTitleController = TextEditingController();
  final editDescController = TextEditingController();

  Future<void> editTask({
    required Map<String, dynamic> data,
  }) async {
    emit(EditTaskLoadingState());
    all = [];
    inProgress = [];
    waiting = [];
    finished = [];
    final params = EditTaskParams(
      id: todo.id,
      data: data,
    );
    final response = await editTaskUsecase(params);
    response.fold(
      (failuer) {
        emit(EditTaskErrorState());
      },
      (success) {
        taskImage = null;
        uploadedImagePath = null;
        getTaskDetails(id: todo.id);
        emit(EditTaskSuccessState());
      },
    );
  }
}
