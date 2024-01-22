import 'package:eddy_profile_book/data/data_sources/local_data/local_storage.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/profiles_storage.dart';
import 'package:eddy_profile_book/data/repositories/profiles_repository.dart';
import 'package:eddy_profile_book/domain/repositories/profiles_repository_impl.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/add_profile_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/delete_profile_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/get_profiles_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/update_profile_use_case.dart';
import 'package:eddy_profile_book/presentation/cubits/add_edit_profile/add_edit_profile_cubit.dart';
import 'package:eddy_profile_book/presentation/cubits/auth/auth_cubit.dart';
import 'package:eddy_profile_book/presentation/cubits/profiles/profiles_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  ///Repository
  getIt.registerLazySingleton<ProfilesRepository>(() => ProfilesRepositoryImpl(getIt()));

  ///Bloc
  getIt.registerSingleton(() => AuthCubit(getIt()));
  getIt.registerLazySingleton(() => ProfilesCubit(getIt(), getIt()));
  getIt.registerLazySingleton(() => AddEditProfileCubit(getIt(), getIt()));

  ///Data sources
  getIt.registerLazySingleton(() => LocalStorage());
  getIt.registerLazySingleton(() => ProfilesStorage());

  ///Use Cases
  getIt.registerLazySingleton(() => GetProfilesUseCase(getIt()));
  getIt.registerLazySingleton(() => AddProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteProfileUseCase(getIt()));
}
