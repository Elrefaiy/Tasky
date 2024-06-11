import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../domain/entities/todo.dart';
import '../widgets/empty_todos.dart';
import '../widgets/todos_list_widget.dart';
import '../../../../config/app_routes.dart';
import '../../../../core/widgets/popup_dialog.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../cubit/todos_cubit.dart';
import '../widgets/categories_list.dart';

import '../widgets/floating_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasky'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              AuthCubit.get(context).getProfileInfo();
              Navigator.pushNamed(
                context,
                Routes.profile,
              );
            },
            icon: const FaIcon(
              FontAwesomeIcons.circleUser,
            ),
          ),
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is UserLogoutSuccessState) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.login,
                  (route) => false,
                );
              }
            },
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return PopupDialog(
                      title: 'Log Out',
                      content: 'are you sure you want to log out ?',
                      buttonText: 'Logout',
                      acceptFunc: () {
                        AuthCubit.get(context).userLogout();
                      },
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.deepPurple,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              await TodosCubit.get(context).getTodosLists();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'My Tasks',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ),
                const CategoriesList(),
                BlocBuilder<TodosCubit, TodosState>(
                  builder: (context, state) {
                    if (state is GetTodosListLoadingState) {
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is GetTodosListSuccessState ||
                        TodosCubit.get(context).all.isNotEmpty) {
                      final index =
                          TodosCubit.get(context).categoriesCurrentIndex;
                      var list = <Todo>[];
                      switch (index) {
                        case 0:
                          list = TodosCubit.get(context).all;
                          break;
                        case 1:
                          list = TodosCubit.get(context).inProgress;
                          break;
                        case 2:
                          list = TodosCubit.get(context).waiting;
                          break;
                        case 3:
                          list = TodosCubit.get(context).finished;
                          break;
                        default:
                      }

                      return TodosListWidget(
                        todos: list,
                      );
                    } else if (state is GetTodosListErrorState) {
                      return Expanded(
                        child: DefaultErrorWidget(
                          refresh: () {
                            TodosCubit.get(context).getTodosLists();
                          },
                        ),
                      );
                    } else if (TodosCubit.get(context).all.isEmpty) {
                      return const Expanded(
                        child: EmptyTodos(),
                      );
                    } else {
                      return Expanded(
                        child: DefaultErrorWidget(
                          refresh: () {
                            TodosCubit.get(context).getTodosLists();
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: const FloatingButtons(),
    );
  }
}
