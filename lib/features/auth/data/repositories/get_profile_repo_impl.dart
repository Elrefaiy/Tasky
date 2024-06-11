import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/get_profile_remote_ds.dart';
import '../models/profile_info_model.dart';
import '../../domain/repositories/get_profile_repo.dart';

class GetProfileInfoRepoImpl implements GetProfileInfoRepo {
  final NetworkInfo networkInfo;
  final GetProfileRemoteDataSource remoteDS;

  GetProfileInfoRepoImpl({
    required this.networkInfo,
    required this.remoteDS,
  });

  @override
  Future<Either<Failure, ProfileInfoModel>> getProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDS.getProfileRemote();
        return Right(response);
      } catch (error) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
