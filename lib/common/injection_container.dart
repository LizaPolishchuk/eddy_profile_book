import 'package:eddy_profile_book/data/data_sources/local_data/local_storage.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/profiles_storage.dart';
import 'package:eddy_profile_book/presentation/cubits/add_edit_profile/add_edit_profile_cubit.dart';
import 'package:eddy_profile_book/presentation/cubits/auth/auth_cubit.dart';
import 'package:eddy_profile_book/presentation/cubits/profiles/profiles_cubit.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

Future<void> init() async {
  ///Repository
  // getIt.registerLazySingleton<Repository>(() => RepositoryImpl(
  //       getIt(),
  //       getIt(),
  //       getIt(),
  //       getIt(),
  //       getIt(),
  //       getIt(),
  //       getIt(),
  //       getIt(),
  //       getIt(),
  //       getIt(),
  //       getIt(),
  //       getIt(),
  //     ));

  ///Bloc
  getIt.registerSingleton(() => AuthCubit(getIt()));
  getIt.registerLazySingleton(() => ProfilesCubit(getIt()));
  getIt.registerLazySingleton(() => AddEditProfileCubit(getIt()));

  ///Data sources
  // getIt.registerLazySingleton<SalonsRemoteDataSource>(() => SalonsRemoteDataSourceImpl(getIt(), getIt()));

  ///Use Cases
  //getIt.registerLazySingleton(() => GetSalonsListUseCase(getIt()));

  ///External
  // final sharedPreferences = await SharedPreferences.getInstance();
  // getIt.registerLazySingleton(() => sharedPreferences);

  getIt.registerLazySingleton(() => LocalStorage());
  getIt.registerLazySingleton(() => ProfilesStorage());

}
