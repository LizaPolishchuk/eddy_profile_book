import 'package:eddy_profile_book/data/local_data/local_storage.dart';
import 'package:eddy_profile_book/data/local_data/profiles_storage.dart';
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
  getIt.registerFactory(() => AuthCubit(getIt()));
  getIt.registerFactory(() => ProfilesCubit(getIt()));

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
