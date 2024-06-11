import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';

abstract class UploadImageRepo {
  Future<Either<Failure, String>> uploadImage({
    required File image,
  });
}
