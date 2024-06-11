import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/usecase/usecase.dart';
import '../models/user_login_model.dart';
import '../../domain/repositories/user_login_repo.dart';

class UserLoginRepoImpl implements UserLoginRepo {
  final NetworkInfo networkInfo;
  final ApiConsumer apiConsumer;
  final SharedPreferences sharedPreferences;

  UserLoginRepoImpl({
    required this.networkInfo,
    required this.apiConsumer,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, UserLoginModel>> userLogin({
    required UserLoginParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiConsumer.post(
          path: EndPoints.login,
          body: {
            'phone': params.phone,
            'password': params.password,
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
        return Right(UserLoginModel.fromJson(response));
      } catch (error) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
