import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/upload_image_repo.dart';

class UploadImageUsecase extends UseCase<String, File> {
  final UploadImageRepo uploadImageRepo;

  UploadImageUsecase({
    required this.uploadImageRepo,
  });
  @override
  Future<Either<Failure, String>> call(File params) {
    return uploadImageRepo.uploadImage(image: params);
  }
}
