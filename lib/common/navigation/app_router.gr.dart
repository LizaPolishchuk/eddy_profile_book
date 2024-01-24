// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddEditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<AddEditProfileRouteArgs>(
          orElse: () => const AddEditProfileRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddEditProfilePage(
          key: args.key,
          profileToEdit: args.profileToEdit,
        ),
      );
    },
    ProfilesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilesPage(),
      );
    },
    SignInRoute.name: (routeData) {
      final args = routeData.argsAs<SignInRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignInPage(
          key: args.key,
          onSignedIn: args.onSignedIn,
        ),
      );
    },
    SignUpRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignUpPage(
          key: args.key,
          email: args.email,
        ),
      );
    },
  };
}

/// generated route for
/// [AddEditProfilePage]
class AddEditProfileRoute extends PageRouteInfo<AddEditProfileRouteArgs> {
  AddEditProfileRoute({
    Key? key,
    Profile? profileToEdit,
    List<PageRouteInfo>? children,
  }) : super(
          AddEditProfileRoute.name,
          args: AddEditProfileRouteArgs(
            key: key,
            profileToEdit: profileToEdit,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEditProfileRoute';

  static const PageInfo<AddEditProfileRouteArgs> page =
      PageInfo<AddEditProfileRouteArgs>(name);
}

class AddEditProfileRouteArgs {
  const AddEditProfileRouteArgs({
    this.key,
    this.profileToEdit,
  });

  final Key? key;

  final Profile? profileToEdit;

  @override
  String toString() {
    return 'AddEditProfileRouteArgs{key: $key, profileToEdit: $profileToEdit}';
  }
}

/// generated route for
/// [ProfilesPage]
class ProfilesRoute extends PageRouteInfo<void> {
  const ProfilesRoute({List<PageRouteInfo>? children})
      : super(
          ProfilesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfilesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    Key? key,
    required void Function() onSignedIn,
    List<PageRouteInfo>? children,
  }) : super(
          SignInRoute.name,
          args: SignInRouteArgs(
            key: key,
            onSignedIn: onSignedIn,
          ),
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<SignInRouteArgs> page = PageInfo<SignInRouteArgs>(name);
}

class SignInRouteArgs {
  const SignInRouteArgs({
    this.key,
    required this.onSignedIn,
  });

  final Key? key;

  final void Function() onSignedIn;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key, onSignedIn: $onSignedIn}';
  }
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    Key? key,
    required String? email,
    List<PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<SignUpRouteArgs> page = PageInfo<SignUpRouteArgs>(name);
}

class SignUpRouteArgs {
  const SignUpRouteArgs({
    this.key,
    required this.email,
  });

  final Key? key;

  final String? email;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key, email: $email}';
  }
}
