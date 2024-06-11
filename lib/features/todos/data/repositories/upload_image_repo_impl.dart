import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/upload_image_repo.dart';

class UploadImageRepoImpl implements UploadImageRepo {
  final ApiConsumer apiConsumer;
  final NetworkInfo networkInfo;

  UploadImageRepoImpl({
    required this.apiConsumer,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> uploadImage({
    required File image,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        FormData formData = FormData.fromMap({
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
            contentType: MediaType("image", "jpeg"),
          ),
        });
        final response = await apiConsumer.post(
          path: EndPoints.upload,
          body: formData,
        );
        return Right(response['image']);
      } catch (error) {
        return const Left(ServerFailure(code: 413));
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
