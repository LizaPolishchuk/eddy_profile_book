import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/profiles_storage.dart';
import 'package:eddy_profile_book/data/repositories/profiles/profiles_repository.dart';
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
  Result<Stream<Iterable<Profile>>> fetchProfiles() {
    try {
      return Result.data(_profilesStorage.fetchProfiles());
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }

  @override
  Future<Result<void>> setProfile(Profile profile) async {
    try {
      await _profilesStorage.setProfile(profile);
      return Result.data();
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteProfile(String profileId) async {
    try {
      await _profilesStorage.deleteProfile(profileId);
      return Result.data();
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }
}
