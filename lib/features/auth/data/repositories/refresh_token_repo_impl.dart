import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/refresh_token_repo.dart';

class RefreshTokenRepoImpl implements RefreshTokenRepo {
  final ApiConsumer apiConsumer;
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  RefreshTokenRepoImpl({
    required this.apiConsumer,
    required this.networkInfo,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, String>> refreshToken() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiConsumer.get(
          path: EndPoints.refreshToken,
          queryParameters: {
            'token': sharedPreferences.getString('refresh_token'),
          },
        );
        await sharedPreferences.setString(
          'access_token',
          response['access_token'],
        );
        return Right(response['access_token']);
      } catch (error) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
