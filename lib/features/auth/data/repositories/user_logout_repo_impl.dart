import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/user_logout_repo.dart';

class UserLogoutRepoImpl implements UserLogoutRepo {
  final ApiConsumer apiConsumer;
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  UserLogoutRepoImpl({
    required this.apiConsumer,
    required this.networkInfo,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, String>> userLogout() async {
    if (await networkInfo.isConnected) {
      try {
        await apiConsumer.post(
          path: EndPoints.logout,
        );
        await sharedPreferences.remove('access_token');
        return const Right('Success');
      } catch (error) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
