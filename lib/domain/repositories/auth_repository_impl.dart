import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/users_storage.dart';
import 'package:eddy_profile_book/data/repositories/auth/auth_repository.dart';
import 'package:eddy_profile_book/domain/entities/failure.dart';
import 'package:eddy_profile_book/domain/entities/user.dart';

class AuthRepositoryImpl extends AuthRepository {
  final UserStorage _userStorage;

  AuthRepositoryImpl(this._userStorage);

  @override
  Future<Result<void>> signIn(String email, String password) async {
    try {
      if (!_userStorage.containsUser(email)) {
        return Result.error(Failure("User with this email not registered!"));
      } else {
        var savedUser = await _userStorage.getUser(email);
        assert(savedUser != null);
        if (savedUser?.password != password) {
          return Result.error(Failure("Invalid password!"));
        } else {
          _userStorage.setLoggedInUserEmail(email);
          return Result.success();
        }
      }
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }

  @override
  Future<Result<void>> signUp(String email, String password) async {
    try {
      if (_userStorage.containsUser(email)) {
        return Result.error(Failure("This login is already taken!"));
      } else {
        await _userStorage.addUser(User(email: email, password: password));
        _userStorage.setLoggedInUserEmail(email);
        return Result.success();
      }
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      _userStorage.setLoggedInUserEmail(null);
      return Result.success();
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }

  @override
  Future<Result<bool>> isUserLoggedIn() async {
    try {
      bool isLoggedIn = await _userStorage.isUserLoggedIn();
      return Result.success(isLoggedIn);
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }
}
