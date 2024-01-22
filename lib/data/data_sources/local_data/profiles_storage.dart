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

  Stream<Iterable<Profile>> fetchProfiles() {
    return Stream.value(_box.listenable()).map((event) => event.value.values);
  }

  List<Profile> getProfiles() {
    return _box.values.toList();
  }

  Future<void> setProfile(Profile profile) async {
    await _box.put(profile.id, profile);
  }

  Future<void> deleteProfile(String profileId) async {
    await _box.delete(profileId);
  }
}
