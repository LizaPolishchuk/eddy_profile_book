import 'package:eddy_profile_book/data/data_sources/local_data/profiles_storage.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/users_storage.dart';
import 'package:eddy_profile_book/data/repositories/auth/auth_repository.dart';
import 'package:eddy_profile_book/data/repositories/profiles/profiles_repository.dart';
import 'package:eddy_profile_book/domain/repositories/auth/auth_repository_impl.dart';
import 'package:eddy_profile_book/domain/repositories/profiles/profiles_repository_impl.dart';
import 'package:eddy_profile_book/domain/use_cases/auth/sign_in_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/auth/sign_out_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/auth/sign_up_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/auth/user_logged_in_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/set_profile_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/delete_profile_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/fetch_profiles_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/get_profiles_use_case.dart';
import 'package:eddy_profile_book/presentation/cubits/add_edit_profile/add_edit_profile_cubit.dart';
import 'package:eddy_profile_book/presentation/cubits/auth/auth_cubit.dart';
import 'package:eddy_profile_book/presentation/cubits/profiles/profiles_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  ///Data sources
  getIt.registerLazySingleton(() => UserStorage());
  getIt.registerLazySingleton(() => ProfilesStorage());

  ///Repository
  getIt.registerLazySingleton<ProfilesRepository>(() => ProfilesRepositoryImpl(getIt()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()));

  ///Use Cases
  getIt.registerLazySingleton(() => GetProfilesUseCase(getIt()));
  getIt.registerLazySingleton(() => FetchProfilesUseCase(getIt()));
  getIt.registerLazySingleton(() => SetProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteProfileUseCase(getIt()));

  getIt.registerLazySingleton(() => SignInUseCase(getIt()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerLazySingleton(() => SignOutUseCase(getIt()));
  getIt.registerLazySingleton(() => UserLoggedInUseCase(getIt()));

  ///Bloc
  getIt.registerSingleton(AuthCubit(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => ProfilesCubit(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => AddEditProfileCubit(getIt()));
}
