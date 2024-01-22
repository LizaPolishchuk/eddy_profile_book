import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/users_storage.dart';
import 'package:eddy_profile_book/data/repositories/auth/auth_repository.dart';
import 'package:eddy_profile_book/domain/entities/failure.dart';
import 'package:eddy_profile_book/domain/entities/user.dart';
import 'package:uuid/uuid.dart';

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
          _userStorage.setIsUserLoggedIn(true);
          return Result.data();
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
        await _userStorage.addUser(User(
          id: const Uuid().v4(),
          email: email,
          password: password,
        ));
        _userStorage.setIsUserLoggedIn(true);
        return Result.data();
      }
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      _userStorage.setIsUserLoggedIn(false);
      return Result.data();
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }

  @override
  Result<Stream<bool>> isUserLoggedIn() {
    try {
      return Result.data(_userStorage.isUserLoggedIn);
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }
}
