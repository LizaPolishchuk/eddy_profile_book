import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  late Box<dynamic> _box;

  static const preferencesBox = '_preferencesBox';
  static const _userEmail = '_email';
  static const _userPassword = '_password';
  static const userLoggedIn = '_loggedIn';

  Future openBox() async {
    _box = await Hive.openBox<dynamic>(preferencesBox);
  }

  bool isUserLoggedIn() => _getValue(userLoggedIn) ?? false;

  Future setIsUserLoggedIn(bool isLoggedIn) => _setValue(userLoggedIn, isLoggedIn);

  Future setUserEmail(String email) => _setValue(_userEmail, email);

  String? getUserEmail() => _getValue(_userEmail);

  Future setUserPassword(String password) => _setValue(_userPassword, password);

  String? getUserPassword() => _getValue(_userPassword);

  T _getValue<T>(dynamic key, {T? defaultValue}) {
    return _box.get(key, defaultValue: defaultValue) as T;
  }

  Future _setValue<T>(dynamic key, T value) {
    return _box.put(key, value);
  }

  Future clearBox() {
    return _box.clear();
  }

  watchBox({dynamic key}) {
    return _box.watch(key: key);
  }
}
