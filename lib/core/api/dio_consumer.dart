import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'app_interceptors.dart';
import 'api_consumer.dart';
import 'end_points.dart';
import '../../injection_container.dart' as di;

class DioConsumer extends ApiConsumer {
  final Dio dio;
  DioConsumer({
    required this.dio,
  }) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.interceptors.add(di.sl<AppIntercepters>());
    // dio.interceptors.add(di.sl<LogInterceptor>());
  }

  @override
  Future get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (error) {
      debugPrint(error.message);
    }
  }

  @override
  Future post({
    required String path,
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return response.data;
    } on DioException catch (error) {
      debugPrint(error.message);
    }
  }

  @override
  Future put({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: body,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (error) {
      debugPrint(error.message);
    }
  }

  @override
  Future delete({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (error) {
      debugPrint(error.message);
    }
  }
}
