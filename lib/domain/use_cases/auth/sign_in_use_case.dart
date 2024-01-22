import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/data/repositories/auth/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<Result<void>> call(String email, String password) async {
    return await repository.signIn(email, password);
  }
}
