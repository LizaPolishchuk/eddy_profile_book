import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/data/repositories/auth/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Result<void>> call(String email, String password) async {
    return await repository.signUp(email, password);
  }
}
