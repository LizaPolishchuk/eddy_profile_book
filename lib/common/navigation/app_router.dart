import 'package:auto_route/auto_route.dart';
import 'package:eddy_profile_book/common/di/injection_container.dart';
import 'package:eddy_profile_book/common/navigation/auth_guard.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';
import 'package:eddy_profile_book/presentation/pages/add_edit_profile/add_edit_profile_page.dart';
import 'package:eddy_profile_book/presentation/pages/auth/sign_in_page.dart';
import 'package:eddy_profile_book/presentation/pages/auth/sign_up_page.dart';
import 'package:eddy_profile_book/presentation/pages/main_list/profiles_page.dart';
import 'package:flutter/foundation.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: signIn, page: SignInRoute.page),
        AutoRoute(path: signUp, page: SignUpRoute.page, keepHistory: false),
        AutoRoute(path: mainProfilesList, page: ProfilesRoute.page, guards: [AuthGuard(getIt())], initial: true),
        AutoRoute(path: addEditProfile, page: AddEditProfileRoute.page),
      ];

  static const String signIn = '/signIn';
  static const String signUp = '/singUp';
  static const String mainProfilesList = '/profiles';
  static const String addEditProfile = '/addEditProfile';
}
