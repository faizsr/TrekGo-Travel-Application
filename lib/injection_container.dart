import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trekgo_project/firebase_options.dart';
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

  // External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton(() => auth);
  getIt.registerLazySingleton(() => fireStore);
  getIt.registerLazySingleton(() => sharedPreferences);

  // Provider Controller
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

  // Use Cases
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

  // Repository
  getIt.registerLazySingleton<UserAuthRepository>(
    () => UserAuthRepositoryImpl(userAuthDataSource: getIt.call()),
  );
  getIt.registerLazySingleton<AuthStatusRepository>(
    () => AuthStatusRepositoryImpl(authStatusDataSource: getIt.call()),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userRemoteDataSource: getIt.call()),
  );

  // Remote DataSource
  getIt.registerLazySingleton<UserAuthRemoteDataSource>(
    () => UserAuthRemoteDataSourceImpl(
        fireStore: getIt.call(), auth: getIt.call()),
  );
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(fireStore: getIt.call(), auth: getIt.call()),
  );

  // Local DataSource
  getIt.registerLazySingleton<AuthStatusDataSource>(
    () => AuthStatusDataSourceImpl(sharedPreferences: getIt.call()),
  );
}
