import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/data/repositories/auth/auth_repository.dart';

class UserLoggedInUseCase {
  final AuthRepository repository;

  UserLoggedInUseCase(this.repository);

  Future<Result<bool>> call() async {
    return await repository.isUserLoggedIn();
  }
}
