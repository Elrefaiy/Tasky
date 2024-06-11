import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/usecase/usecase.dart';
import '../models/user_register_model.dart';
import '../../domain/repositories/user_register_repo.dart';

class UserRegisterRepoImpl implements UserRegisterRepo {
  final NetworkInfo networkInfo;
  final ApiConsumer apiConsumer;
  final SharedPreferences sharedPreferences;
  UserRegisterRepoImpl({
    required this.networkInfo,
    required this.apiConsumer,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, UserRegisterModel>> userRegister({
    required UserRegisterParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiConsumer.post(
          path: EndPoints.register,
          body: {
            'phone': params.phone,
            'password': params.password,
            'displayName': params.displayName,
            'experienceYears': params.experienceYears,
            'address': params.address,
            'level': params.level,
          },
        );
        await sharedPreferences.setString(
          'access_token',
          response['access_token'],
        );
        await sharedPreferences.setString(
          'refresh_token',
          response['refresh_token'],
        );
        return Right(UserRegisterModel.fromJson(response));
      } catch (error) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
