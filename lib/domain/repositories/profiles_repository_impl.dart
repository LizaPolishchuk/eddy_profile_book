import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/profiles_storage.dart';
import 'package:eddy_profile_book/data/repositories/profiles_repository.dart';
import 'package:eddy_profile_book/domain/entities/failure.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';

class ProfilesRepositoryImpl extends ProfilesRepository {
  final ProfilesStorage _profilesStorage;

  ProfilesRepositoryImpl(this._profilesStorage);

  @override
  Result<List<Profile>> getProfiles() {
    try {
      return Result.data(_profilesStorage.getProfiles());
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }

  @override
  Future<Result<void>> addProfile(Profile profile) async {
    try {
      await _profilesStorage.addProfile(profile);
      return Result.data();
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }

  @override
  Future<Result<void>> updateProfile(int index, Profile profile) async {
    try {
      await _profilesStorage.updateProfile(index, profile);
      return Result.data();
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteProfile(int index) async {
    try {
      await _profilesStorage.deleteProfile(index);
      return Result.data();
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }
}
