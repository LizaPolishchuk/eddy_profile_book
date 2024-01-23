import 'package:eddy_profile_book/data/repositories/auth/auth_repository.dart';

class UserLoggedInUseCase {
  final AuthRepository repository;

  UserLoggedInUseCase(this.repository);

  Future<bool> get isUserLoggedIn async {
    var result = await repository.isUserLoggedIn();
    return result.data ?? false;
  }

  get isUserLoggedInStream {
    var result = repository.isUserLoggedInStream();
    if (result.hasError) {
      return;
    } else {
      return result.data;
    }
  }
}
