import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Result<void>> signIn(String email, String password);

  Future<Result<void>> signUp(String email, String password);

  Future<Result<void>> signOut();

  Result<Stream<bool>> isUserLoggedInStream();

  Future<Result<bool>> isUserLoggedIn();
}
