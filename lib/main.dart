import 'package:eddy_profile_book/common/di/injection_container.dart' as dependency_injection;
import 'package:eddy_profile_book/common/di/injection_container.dart';
import 'package:eddy_profile_book/common/navigation/app_router.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/profiles_storage.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/users_storage.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';
import 'package:eddy_profile_book/domain/entities/user.dart';
import 'package:eddy_profile_book/domain/use_cases/auth/user_logged_in_use_case.dart';
import 'package:eddy_profile_book/presentation/cubits/auth/auth_cubit.dart';
import 'package:eddy_profile_book/presentation/pages/auth/sign_in_page.dart';
import 'package:eddy_profile_book/presentation/pages/main_list/profiles_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dependency_injection.init();
  await _initHive();

  final isUserLoggedIn = (await getIt<UserLoggedInUseCase>().call()).data ?? false;

  runApp(MyApp(
    isUserLoggedIn: isUserLoggedIn,
  ));
}

Future<void> _initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  await getIt<UserStorage>().openBox();

  Hive.registerAdapter(ProfileAdapter());
  await getIt<ProfilesStorage>().openBox();
}

class MyApp extends StatelessWidget {
  final bool isUserLoggedIn;
  final _appRouter = AppRouter();

  MyApp({super.key, required this.isUserLoggedIn});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt(), getIt(), getIt()),
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
