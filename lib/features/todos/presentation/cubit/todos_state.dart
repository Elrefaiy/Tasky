part of 'todos_cubit.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosInitial extends TodosState {}

class ChangeCategoriesCurrentIndexState extends TodosState {}

class ChangeTaskPriorityState extends TodosState {}

class GetTodosListLoadingState extends TodosState {}

class GetTodosListSuccessState extends TodosState {}

class GetTodosListErrorState extends TodosState {}

class GetTaskDetailsLoadingState extends TodosState {}

class GetTaskDetailsSuccessState extends TodosState {
  final Todo todo;
  const GetTaskDetailsSuccessState({required this.todo});
  @override
  List<Object> get props => [todo];
}

class GetTaskDetailsErrorState extends TodosState {}

class PickImageSuccessState extends TodosState {}

class RemoveImageSuccessState extends TodosState {}

class UploadImageLoadingState extends TodosState {}

class UploadImageSuccessState extends TodosState {}

class UploadImageErrorState extends TodosState {}

class CreateTaskLoadingState extends TodosState {}

class CreateTaskSuccessState extends TodosState {}

class CreateTaskErrorState extends TodosState {}

class NoInternetConnectionState extends TodosState {}

class DeleteTaskLoadingState extends TodosState {}

class DeleteTaskSuccessState extends TodosState {}

class DeleteTaskErrorState extends TodosState {}

class ChangeStatusState extends TodosState {}

class EditTaskLoadingState extends TodosState {}

class EditTaskSuccessState extends TodosState {}

class EditTaskErrorState extends TodosState {}

class SetBarcodeSuccessState extends TodosState {}
