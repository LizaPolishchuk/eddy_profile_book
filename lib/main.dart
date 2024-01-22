import 'package:eddy_profile_book/common/injection_container.dart' as dependency_injection;
import 'package:eddy_profile_book/common/injection_container.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/profiles_storage.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/users_storage.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';
import 'package:eddy_profile_book/domain/entities/user.dart';
import 'package:eddy_profile_book/domain/use_cases/auth/user_logged_in_use_case.dart';
import 'package:eddy_profile_book/presentation/pages/auth/sign_in_page.dart';
import 'package:eddy_profile_book/presentation/pages/profiles_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dependency_injection.init();
  await _initHive();

  runApp(const MyApp());
}

Future<void> _initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  await getIt<UserStorage>().openBox();

  Hive.registerAdapter(ProfileAdapter());
  await getIt<ProfilesStorage>().openBox();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InitialPage(),
    );
  }
}

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: getIt<UserLoggedInUseCase>().isUserLoggedInStream,
      builder: (context, snapshot) {
        print("isUserLoggedIn: ${snapshot.data}");
        bool isLoggedIn = snapshot.data ?? false; //?.value ?? _localStorage.isUserLoggedIn();

        return isLoggedIn ? ProfilesPage() : AuthPage();
      },
    );
  }
}
