import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import 'status_code.dart';
import '../../injection_container.dart' as di;

class AppIntercepters extends Interceptor {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  AppIntercepters({
    required this.dio,
    required this.sharedPreferences,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    String? authToken = sharedPreferences.getString('access_token');
    if (authToken != null && authToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ToDo
    super.onResponse(response, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final cubit = di.sl<AuthCubit>();
    switch (err.response?.statusCode) {
      case StatusCode.unauthorized:
        {
          String? authToken = sharedPreferences.getString('access_token');
          if (authToken != null && authToken.isNotEmpty) {
            cubit.refreshToken();
            authToken = sharedPreferences.getString('access_token');
            err.requestOptions.headers['Authorization'] = 'Bearer $authToken';
            return handler.resolve(await dio.fetch(err.requestOptions));
          }
        }
      case StatusCode.refreshFaild:
        break;
      default:
    }
    super.onError(err, handler);
  }
}
