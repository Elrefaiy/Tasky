import 'package:shared_preferences/shared_preferences.dart';
import '../../injection_container.dart' as di;

class AppStrings {
  static const String appName = 'Tasky';
  static const String assetImage = 'assets/images/';
  static const String introTitle = 'Task Management &\nTo-Do List';
  static const String introContext =
      'This productive tool is designed to help\nyou better manage your task\nproject-wise conveniently!';
  static const String loginErrorMsg =
      'User Login Error Occurs, Please Try Again!';
  static const String registerErrorMsg =
      'User Register Error Occurs, Please Try Again!';
  static String? accessToken =
      di.sl<SharedPreferences>().getString('access_token');
  static const String imageBase = 'https://todo.iraqsapp.com/images/';
}
