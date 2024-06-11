class EndPoints {
  static const String baseUrl = 'https://todo.iraqsapp.com/';
  // Auth
  static const String login = '${baseUrl}auth/login';
  static const String logout = '${baseUrl}auth/logout';
  static const String register = '${baseUrl}auth/register';
  static const String profile = '${baseUrl}auth/profile';
  static const String refreshToken = '${baseUrl}auth/refresh-token';

  // Todos
  static const String todosList = '${baseUrl}todos';
  static String taskDetails({required String id}) => '${baseUrl}todos/$id';
  static const String upload = '${baseUrl}upload/image';
}
