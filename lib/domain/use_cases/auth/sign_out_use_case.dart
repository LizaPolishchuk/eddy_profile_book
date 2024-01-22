import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/data/repositories/auth/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<Result<void>> call() async {
    return await repository.signOut();
  }
}
