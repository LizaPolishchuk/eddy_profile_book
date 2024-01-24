import 'package:auto_route/auto_route.dart';
import 'package:eddy_profile_book/common/navigation/app_router.dart';
import 'package:eddy_profile_book/domain/use_cases/auth/user_logged_in_use_case.dart';

class AuthGuard extends AutoRouteGuard {
  final UserLoggedInUseCase _userLoggedInUseCase;

  AuthGuard(this._userLoggedInUseCase);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    bool isLoggedIn = (await _userLoggedInUseCase()).data ?? false;

    if (isLoggedIn) {
      resolver.next(true);
    } else {
      router.push(SignInRoute(onSignedIn: () {
        if (router.pageCount > 1) {
          router.popUntilRoot();
        }
        resolver.redirect(resolver.route.toPageRouteInfo(), replace: true);
      }));
    }
  }
}
