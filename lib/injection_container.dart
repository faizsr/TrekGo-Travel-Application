import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trekgo_project/firebase_options.dart';
import 'package:trekgo_project/src/feature/admin/data/data_sources/remote/destinations/manage_destinations_data_source.dart';
import 'package:trekgo_project/src/feature/admin/data/data_sources/remote/destinations/manage_destinations_data_source_impl.dart';
import 'package:trekgo_project/src/feature/admin/data/data_sources/remote/users/manage_users_data_source.dart';
import 'package:trekgo_project/src/feature/admin/data/data_sources/remote/users/manage_users_data_source_impl.dart';
import 'package:trekgo_project/src/feature/admin/data/repositories/manage_destinations_repository_impl.dart';
import 'package:trekgo_project/src/feature/admin/data/repositories/manage_users_repository_impl.dart';
import 'package:trekgo_project/src/feature/admin/domain/repositories/manage_destinations_repository.dart';
import 'package:trekgo_project/src/feature/admin/domain/repositories/manage_users_repository.dart';
import 'package:trekgo_project/src/feature/admin/domain/usecases/destination/add_destination_usecase.dart';
import 'package:trekgo_project/src/feature/admin/domain/usecases/destination/delete_destination_usecase.dart';
import 'package:trekgo_project/src/feature/admin/domain/usecases/destination/update_destination_usecase.dart';
import 'package:trekgo_project/src/feature/admin/domain/usecases/user/block_user_usecase.dart';
import 'package:trekgo_project/src/feature/admin/domain/usecases/user/fetch_all_users_usecase.dart';
import 'package:trekgo_project/src/feature/admin/domain/usecases/user/unblock_user_usecase.dart';
import 'package:trekgo_project/src/feature/admin/presentation/controllers/manage_destination_controller.dart';
import 'package:trekgo_project/src/feature/admin/presentation/controllers/manage_user_controller.dart';
import 'package:trekgo_project/src/feature/auth/data/data_sources/local/auth_status_data_source.dart';
import 'package:trekgo_project/src/feature/auth/data/data_sources/local/auth_status_data_source_impl.dart';
import 'package:trekgo_project/src/feature/auth/data/data_sources/remote/user_auth_data_source.dart';
import 'package:trekgo_project/src/feature/auth/data/data_sources/remote/user_auth_data_source_impl.dart';
import 'package:trekgo_project/src/feature/auth/data/repositories/auth_status_repository_impl.dart';
import 'package:trekgo_project/src/feature/auth/data/repositories/user_auth_repository_impl.dart';
import 'package:trekgo_project/src/feature/auth/domain/repositories/auth_status_repository.dart';
import 'package:trekgo_project/src/feature/auth/domain/repositories/user_auth_repository.dart';
import 'package:trekgo_project/src/feature/auth/domain/use_cases/auth_status_usecase.dart';
import 'package:trekgo_project/src/feature/auth/domain/use_cases/forgot_password_usecase.dart';
import 'package:trekgo_project/src/feature/auth/domain/use_cases/user_login_usecase.dart';
import 'package:trekgo_project/src/feature/auth/domain/use_cases/user_logout_usecase.dart';
import 'package:trekgo_project/src/feature/auth/domain/use_cases/user_sign_up_usecase.dart';
import 'package:trekgo_project/src/feature/auth/presentation/controllers/auth_controller.dart';
import 'package:trekgo_project/src/feature/destination/data/data_sources/remote/destination_data_source.dart';
import 'package:trekgo_project/src/feature/destination/data/data_sources/remote/destination_data_source_impl.dart';
import 'package:trekgo_project/src/feature/destination/data/repositories/destination_repository_impl.dart';
import 'package:trekgo_project/src/feature/destination/domain/repositories/destination_repository.dart';
import 'package:trekgo_project/src/feature/destination/domain/use_cases/get_popular_destination_usecase.dart';
import 'package:trekgo_project/src/feature/destination/domain/use_cases/get_recommended_destination_usecase.dart';
import 'package:trekgo_project/src/feature/destination/presentation/controllers/destination_controller.dart';
import 'package:trekgo_project/src/feature/user/data/data_sources/user_remote_data_source.dart';
import 'package:trekgo_project/src/feature/user/data/data_sources/user_remote_data_source_impl.dart';
import 'package:trekgo_project/src/feature/user/data/repositories/user_repository_impl.dart';
import 'package:trekgo_project/src/feature/user/domain/repositories/user_repository.dart';
import 'package:trekgo_project/src/feature/user/domain/usecases/get_user_details_usecase.dart';
import 'package:trekgo_project/src/feature/user/domain/usecases/update_user_details_usecase.dart';
import 'package:trekgo_project/src/feature/user/presentation/controllers/user_controller.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ---------------------- External ----------------------
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final fireStorage = FirebaseStorage.instance;
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton(() => auth);
  getIt.registerLazySingleton(() => fireStore);
  getIt.registerLazySingleton(() => fireStorage);
  getIt.registerLazySingleton(() => sharedPreferences);

  // ---------------------- Provider Controller ----------------------
  // ====== User ======
  getIt.registerFactory<AuthController>(
    () => AuthController(
      authStatusUsecase: getIt.call(),
      userLoginInUsecase: getIt.call(),
      userLogoutUsecase: getIt.call(),
      forgotPasswordUsecase: getIt.call(),
      userSignUpUsecase: getIt.call(),
    ),
  );
  getIt.registerFactory<UserController>(
    () => UserController(
      getUserDetailsUsecase: getIt.call(),
      updateUserDetailsUsecase: getIt.call(),
    ),
  );
  // ====== Destination ======
  getIt.registerFactory<DestinationController>(
    () => DestinationController(
      getPopularDestinationUsecase: getIt.call(),
      getRecommendedDestinationUsecase: getIt.call(),
    ),
  );
  // ====== Admin ======
  getIt.registerFactory<ManageDestinationController>(
    () => ManageDestinationController(
      addDestinationUsecase: getIt.call(),
      updateDestinationUsecase: getIt.call(),
      deleteDestinationUsecase: getIt.call(),
    ),
  );
  getIt.registerLazySingleton<ManageUserController>(
    () => ManageUserController(
      fetchAllUsersUsecase: getIt.call(),
      blockUserUsecase: getIt.call(),
      unblockUserUsecase: getIt.call(),
    ),
  );

  // ---------------------- Use Cases ----------------------
  // ====== User ======
  getIt.registerLazySingleton<UserLoginInUsecase>(
    () => UserLoginInUsecase(userAuthRepository: getIt.call()),
  );
  getIt.registerLazySingleton<UserSignUpUsecase>(
    () => UserSignUpUsecase(userAuthRepository: getIt.call()),
  );
  getIt.registerLazySingleton<UserLogoutUsecase>(
    () => UserLogoutUsecase(userAuthRepository: getIt.call()),
  );
  getIt.registerLazySingleton<ForgotPasswordUsecase>(
    () => ForgotPasswordUsecase(userAuthRepository: getIt.call()),
  );
  getIt.registerLazySingleton<AuthStatusUsecase>(
    () => AuthStatusUsecase(authStatusRepository: getIt.call()),
  );
  getIt.registerLazySingleton<GetUserDetailsUsecase>(
    () => GetUserDetailsUsecase(userRepository: getIt.call()),
  );
  getIt.registerLazySingleton<UpdateUserDetailsUsecase>(
    () => UpdateUserDetailsUsecase(userRepository: getIt.call()),
  );
  // ====== Destination ======
  getIt.registerLazySingleton<GetRecommendedDestinationUsecase>(
    () => GetRecommendedDestinationUsecase(destinationRepository: getIt.call()),
  );
  getIt.registerLazySingleton<GetPopularDestinationUsecase>(
    () => GetPopularDestinationUsecase(destinationRepository: getIt.call()),
  );
  // ====== Admin ======
  getIt.registerLazySingleton<AddDestinationUsecase>(
    () => AddDestinationUsecase(manageDestinationsRepository: getIt.call()),
  );
  getIt.registerLazySingleton<UpdateDestinationUsecase>(
    () => UpdateDestinationUsecase(manageDestinationsRepository: getIt.call()),
  );
  getIt.registerLazySingleton<DeleteDestinationUsecase>(
    () => DeleteDestinationUsecase(manageDestinationsRepository: getIt.call()),
  );
  getIt.registerLazySingleton<FetchAllUsersUsecase>(
    () => FetchAllUsersUsecase(manageUsersRepository: getIt.call()),
  );
  getIt.registerLazySingleton<BlockUserUsecase>(
    () => BlockUserUsecase(manageUsersRepository: getIt.call()),
  );
  getIt.registerLazySingleton<UnblockUserUsecase>(
    () => UnblockUserUsecase(manageUsersRepository: getIt.call()),
  );

  // ---------------------- Repository ----------------------
  // ====== User ======
  getIt.registerLazySingleton<UserAuthRepository>(
    () => UserAuthRepositoryImpl(userAuthDataSource: getIt.call()),
  );
  getIt.registerLazySingleton<AuthStatusRepository>(
    () => AuthStatusRepositoryImpl(authStatusDataSource: getIt.call()),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userRemoteDataSource: getIt.call()),
  );
  // ====== Destination ======
  getIt.registerLazySingleton<DestinationRepository>(
    () => DestinationRepositoryImpl(destinationDataSource: getIt.call()),
  );
  // ====== Admin ======
  getIt.registerLazySingleton<ManageDestinationsRepository>(
    () => ManageDestinationsRepositoryImpl(
        manageDestinationsDataSource: getIt.call()),
  );
  getIt.registerLazySingleton<ManageUsersRepository>(
    () => ManageUsersRepositoryImpl(manageUserDataSource: getIt.call()),
  );

  // ---------------------- Remote DataSource ----------------------
  // ====== User ======
  getIt.registerLazySingleton<UserAuthRemoteDataSource>(
    () => UserAuthRemoteDataSourceImpl(
        fireStore: getIt.call(), auth: getIt.call()),
  );
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(fireStore: getIt.call(), auth: getIt.call()),
  );
  // ====== Destination ======
  getIt.registerLazySingleton<DestinationDataSource>(
    () => DestinationDataSourceImpl(fireStore: getIt.call()),
  );
  // ====== Admin ======
  getIt.registerLazySingleton<ManageDestinationsDataSource>(
    () => ManageDestinationsDataSourceImpl(
        fireStore: getIt.call(), fireStorage: getIt.call()),
  );
  getIt.registerLazySingleton<ManageUsersDataSource>(
    () => ManageUsersDataSourceImpl(fireStore: getIt.call()),
  );

  // ---------------------- Local DataSource ----------------------
  // ====== User ======
  getIt.registerLazySingleton<AuthStatusDataSource>(
    () => AuthStatusDataSourceImpl(sharedPreferences: getIt.call()),
  );
}
