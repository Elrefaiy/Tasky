import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';

import '../models/profile_info_model.dart';

abstract class GetProfileRemoteDataSource {
  Future<ProfileInfoModel> getProfileRemote();
}

class GetProfileRemoteDataSourceImpl implements GetProfileRemoteDataSource {
  final ApiConsumer apiConsumer;

  GetProfileRemoteDataSourceImpl({
    required this.apiConsumer,
  });

  @override
  Future<ProfileInfoModel> getProfileRemote() async {
    final response = await apiConsumer.get(
      path: EndPoints.profile,
    );
    return ProfileInfoModel.fromJson(response);
  }
}
