import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/todos/data/repositories/create_task_repo_impl.dart';
import 'features/todos/data/repositories/delete_task_repo_impl.dart';
import 'features/todos/data/repositories/edit_task_repo_impl.dart';
import 'features/todos/data/repositories/upload_image_repo_impl.dart';
import 'features/todos/domain/repositories/create_task_repo.dart';
import 'features/todos/domain/repositories/delete_task_repo.dart';
import 'features/todos/domain/repositories/edit_task_repo.dart';
import 'features/todos/domain/repositories/upload_image_repo.dart';
import 'features/todos/domain/usecases/create_task_usecase.dart';
import 'features/todos/domain/usecases/delete_task_usecase.dart';
import 'features/todos/domain/usecases/edit_task_usecase.dart';
import 'features/todos/domain/usecases/upload_image_usecase.dart';
import 'features/auth/data/repositories/refresh_token_repo_impl.dart';
import 'features/auth/data/repositories/user_logout_repo_impl.dart';
import 'features/auth/domain/repositories/refresh_token_repo.dart';
import 'features/auth/domain/repositories/user_logout_repo.dart';
import 'features/auth/domain/usecases/refresh_token_usecase.dart';
import 'features/auth/domain/usecases/user_logout_usecase.dart';
import 'features/todos/data/datasources/get_task_details_remote_ds.dart';
import 'features/todos/data/datasources/get_todos_list_remote_ds.dart';
import 'features/todos/data/repositories/get_task_details_repo_impl.dart';
import 'features/todos/data/repositories/get_todos_list_repo_impl.dart';
import 'features/todos/domain/repositories/get_task_details_repo.dart';
import 'features/todos/domain/repositories/get_todos_list_repo.dart';
import 'features/todos/domain/usecases/get_task_details_usecase.dart';
import 'features/todos/domain/usecases/get_todos_list_usecase.dart';
import 'core/api/app_interceptors.dart';
import 'features/auth/data/datasources/get_profile_remote_ds.dart';
import 'features/auth/data/repositories/get_profile_repo_impl.dart';
import 'features/auth/data/repositories/user_register_repo_impl.dart';
import 'features/auth/domain/repositories/get_profile_repo.dart';
import 'features/auth/domain/repositories/user_register_repo.dart';
import 'features/auth/domain/usecases/get_profile_usecase.dart';
import 'features/auth/domain/usecases/user_register_usecase.dart';
import 'features/todos/presentation/cubit/todos_cubit.dart';
import 'features/auth/data/repositories/user_login_repo_impl.dart';
import 'features/auth/domain/repositories/user_login_repo.dart';
import 'features/auth/domain/usecases/user_login_usecase.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

import 'core/api/api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLOCS
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      userLoginUsecase: sl(),
      userRegisterUsecase: sl(),
      getProfileUsecase: sl(),
      refreshTokenUsecase: sl(),
      userLogoutUsecase: sl(),
    ),
  );
  sl.registerFactory<TodosCubit>(
    () => TodosCubit(
      getTodosListUsecase: sl(),
      getTaskDetailsUsecase: sl(),
      uploadImageUsecase: sl(),
      createTaskUseCase: sl(),
      deleteTaskUsecase: sl(),
      editTaskUsecase: sl(),
    ),
  );

  // USE CASES
  sl.registerLazySingleton<UserLoginUsecase>(
    () => UserLoginUsecase(
      userLoginRepo: sl(),
    ),
  );
  sl.registerLazySingleton<UserRegisterUsecase>(
    () => UserRegisterUsecase(
      userRegisterRepo: sl(),
    ),
  );
  sl.registerLazySingleton<GetProfileUsecase>(
    () => GetProfileUsecase(
      getProfileInfoRepo: sl(),
    ),
  );
  sl.registerLazySingleton<RefreshTokenUsecase>(
    () => RefreshTokenUsecase(
      refreshTokenRepo: sl(),
    ),
  );
  sl.registerLazySingleton<UserLogoutUsecase>(
    () => UserLogoutUsecase(
      userLogoutRepo: sl(),
    ),
  );

  sl.registerLazySingleton<GetTodosListUsecase>(
    () => GetTodosListUsecase(
      getTodosListRepo: sl(),
    ),
  );
  sl.registerLazySingleton<GetTaskDetailsUsecase>(
    () => GetTaskDetailsUsecase(
      getTaskDetailsRepo: sl(),
    ),
  );
  sl.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      uploadImageRepo: sl(),
    ),
  );
  sl.registerLazySingleton<CreateTaskUseCase>(
    () => CreateTaskUseCase(
      createTaskRepo: sl(),
    ),
  );
  sl.registerLazySingleton<DeleteTaskUsecase>(
    () => DeleteTaskUsecase(
      deleteTaskRepo: sl(),
    ),
  );
  sl.registerLazySingleton<EditTaskUsecase>(
    () => EditTaskUsecase(
      editTaskRepo: sl(),
    ),
  );
  // REPOSITORIES
  sl.registerLazySingleton<UserLoginRepo>(
    () => UserLoginRepoImpl(
      networkInfo: sl(),
      apiConsumer: sl(),
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<UserRegisterRepo>(
    () => UserRegisterRepoImpl(
      networkInfo: sl(),
      apiConsumer: sl(),
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<GetProfileInfoRepo>(
    () => GetProfileInfoRepoImpl(
      networkInfo: sl(),
      remoteDS: sl(),
    ),
  );
  sl.registerLazySingleton<RefreshTokenRepo>(
    () => RefreshTokenRepoImpl(
      networkInfo: sl(),
      apiConsumer: sl(),
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<UserLogoutRepo>(
    () => UserLogoutRepoImpl(
      networkInfo: sl(),
      apiConsumer: sl(),
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<GetTodosListRepo>(
    () => GetTodosListRepoImpl(
      networkInfo: sl(),
      remoteDS: sl(),
    ),
  );
  sl.registerLazySingleton<GetTaskDetailsRepo>(
    () => GetTaskDetailsRepoImpl(
      networkInfo: sl(),
      remoteDS: sl(),
    ),
  );
  sl.registerLazySingleton<UploadImageRepo>(
    () => UploadImageRepoImpl(
      networkInfo: sl(),
      apiConsumer: sl(),
    ),
  );
  sl.registerLazySingleton<CreateTaskRepo>(
    () => CreateTaskRepoImpl(
      networkInfo: sl(),
      apiConsumer: sl(),
    ),
  );
  sl.registerLazySingleton<DeleteTaskRepo>(
    () => DeleteTaskRepoImpl(
      networkInfo: sl(),
      apiConsumer: sl(),
    ),
  );
  sl.registerLazySingleton<EditTaskRepo>(
    () => EditTaskRepoImpl(
      networkInfo: sl(),
      apiConsumer: sl(),
    ),
  );

  // DATA SOURCES
  sl.registerLazySingleton<GetProfileRemoteDataSource>(
    () => GetProfileRemoteDataSourceImpl(
      apiConsumer: sl(),
    ),
  );

  sl.registerLazySingleton<GetTodosListRemoteDS>(
    () => GetTodosListRemoteDSImpl(
      apiConsumer: sl(),
    ),
  );
  sl.registerLazySingleton<GetTaskDetailsRemoteDS>(
    () => GetTaskDetailsRemoteDSImpl(
      apiConsumer: sl(),
    ),
  );
  // CORE
  sl.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(
      dio: sl(),
    ),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetConnectionChecker: sl()),
  );

  // EXTERNALS
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => AppIntercepters(
        dio: sl(),
        sharedPreferences: sl(),
      ));
  // sl.registerLazySingleton(
  //   () => LogInterceptor(
  //     responseBody: true,
  //     error: true,
  //   ),
  // );
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
