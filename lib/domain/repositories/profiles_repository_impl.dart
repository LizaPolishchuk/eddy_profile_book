import 'package:eddy_profile_book/common/di/injection_container.dart';
import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/profiles_storage.dart';
import 'package:eddy_profile_book/data/data_sources/local_data/users_storage.dart';
import 'package:eddy_profile_book/data/repositories/profiles/profiles_repository.dart';
import 'package:eddy_profile_book/domain/entities/failure.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';

class ProfilesRepositoryImpl extends ProfilesRepository {
  final ProfilesStorage _profilesStorage;

  ProfilesRepositoryImpl(this._profilesStorage);

  @override
  Future<Result<List<Profile>>> getProfiles() async {
    try {
      var currentUserEmail = await getIt<UserStorage>().getCurrentUserEmail();
      assert(currentUserEmail != null);
      return Result.success(_profilesStorage.getProfiles(currentUserEmail!));
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }

  @override
  Future<Result<void>> setProfile(Profile profile) async {
    try {
      if (profile.creatorEmail.isEmpty) {
        var currentUserEmail = await getIt<UserStorage>().getCurrentUserEmail();

        assert(currentUserEmail != null);

        profile.creatorEmail = currentUserEmail!;
      }
      await _profilesStorage.setProfile(profile);
      return Result.success();
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteProfile(String profileId) async {
    try {
      await _profilesStorage.deleteProfile(profileId);
      return Result.success();
    } catch (e) {
      return Result.error(Failure(e.toString()));
    }
  }
}
