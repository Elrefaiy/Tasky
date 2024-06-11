import 'package:flutter/material.dart';
import 'core/utils/app_strings.dart';
import 'features/auth/presentation/screens/intro_screen.dart';
import 'features/todos/presentation/screens/home_screen.dart';

import 'app.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  // Bloc.observer = MyBlocObserver();
  Widget startWidget = const IntroScreen();
  if (AppStrings.accessToken != null) {
    startWidget = const HomeScreen();
  }
  runApp(
    MyApp(
      startWidget: startWidget,
    ),
  );
}
