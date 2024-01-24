import 'dart:convert';
import 'package:eddy_profile_book/domain/entities/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

const int hiveTypeUsers = 1;
const String storageKey = 'storageKey';

class UserStorage {
  final _usersBox = '_usersBox';
  final _currentUserEmail = '_userEmail';

  late Box<dynamic> _box;

  Future openBox() async {
    const secureStorage = FlutterSecureStorage();
    final isContainKey = await secureStorage.containsKey(key: storageKey);
    if (!isContainKey) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: storageKey,
        value: base64UrlEncode(key),
      );
    }
    final key = await secureStorage.read(key: storageKey);
    final encryptionKeyUint8List = base64Url.decode(key!);
    _box = await Hive.openBox<dynamic>(_usersBox, encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
  }

  Future<bool> isUserLoggedIn() async {
    return (await getCurrentUserEmail())?.isNotEmpty ?? false;
  }

  Future<void> setLoggedInUserEmail(String? userEmail) async {
    await _box.put(_currentUserEmail, userEmail);
  }

  Future<String?> getCurrentUserEmail() async {
    return await _box.get(_currentUserEmail);
  }

  Future<void> addUser(User user) async {
    await _box.put(user.email, user);
  }

  Future<User?> getUser(String email) async {
    return _box.get(email);
  }

  Future<List<User>> getUsers() async {
    return _box.values.whereType<User>().toList();
  }

  bool containsUser(String email) {
    return _box.containsKey(email);
  }
}
