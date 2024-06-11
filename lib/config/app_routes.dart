import 'package:flutter/material.dart';
import '../features/todos/presentation/screens/edit_task_screen.dart';
import '../features/todos/presentation/screens/qr_scanner_screen.dart';
import '../features/todos/presentation/screens/task_details_screen.dart';
import '../features/todos/presentation/screens/add_task_screen.dart';
import '../features/todos/presentation/screens/home_screen.dart';
import '../features/auth/presentation/screens/profile_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';

import '../features/auth/presentation/screens/intro_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';

class Routes {
  static const String intro = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String addTask = '/addTask';
  static const String taskDetails = '/taskDetails';
  static const String editTask = '/editTask';
  static const String qrScanner = '/qrScanner';
}

class AppRoutes {
  static MaterialPageRoute? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.intro:
        return MaterialPageRoute(
          builder: (context) => const IntroScreen(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case Routes.addTask:
        return MaterialPageRoute(
          builder: (context) => const AddTaskScreen(),
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );
      case Routes.taskDetails:
        {
          final String id = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => TaskDetailsScreen(
              id: id,
            ),
          );
        }
      case Routes.editTask:
        {
          final String id = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => EditTaskScreen(
              id: id,
            ),
          );
        }
      case Routes.qrScanner:
        {
          return MaterialPageRoute(
            builder: (context) => const QrScannerScreen(),
          );
        }
      default:
        return MaterialPageRoute(
          builder: (context) => const NotExpectedRouteErrorSreen(),
        );
    }
  }
}

class NotExpectedRouteErrorSreen extends StatelessWidget {
  const NotExpectedRouteErrorSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Error, Not Expected Route!',
          textScaler: TextScaler.linear(2),
        ),
      ),
    );
  }
}
