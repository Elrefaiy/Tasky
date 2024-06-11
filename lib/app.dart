import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/app_routes.dart';
import 'config/app_theme.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/todos/presentation/cubit/todos_cubit.dart';
import 'injection_container.dart' as di;

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({
    required this.startWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<TodosCubit>()..getTodosLists(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: AppTheme.appLightTheme(),
        home: startWidget,
      ),
    );
  }
}
