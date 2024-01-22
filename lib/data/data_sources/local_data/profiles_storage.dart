import 'package:eddy_profile_book/domain/entities/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

const int hiveTypeProfiles = 0;

class ProfilesStorage {
  static const _profilesBox = '_profilesBox';

  late Box<Profile> _box;

  Future openBox() async {
    _box = await Hive.openBox<Profile>(_profilesBox);
  }

  ValueListenable<Box<Profile>> fetchProfiles() {
    return _box.listenable();
  }

  List<Profile> getProfiles() {
    return _box.values.toList();
  }

  Future<void> addProfile(Profile profile) async {
    await _box.add(profile);
  }

  Future<void> updateProfile(int index, Profile profile) async {
    await _box.putAt(index, profile);
  }

  Future<void> deleteProfile(int index) async {
    await _box.deleteAt(index);
  }
}
