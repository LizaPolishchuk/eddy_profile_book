import 'package:eddy_profile_book/data/repositories/auth/auth_repository.dart';

class UserLoggedInUseCase {
  final AuthRepository repository;

  UserLoggedInUseCase(this.repository);

  get isUserLoggedInStream {
    var result = repository.isUserLoggedIn();
    if (result.hasError) {
      return;
    } else {
      return result.data;
    }
  }
}
