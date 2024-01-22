import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';

abstract class ProfilesRepository {
  Result<List<Profile>> getProfiles();

  Future<Result<void>> addProfile(Profile profile);

  Future<Result<void>> updateProfile(int index, Profile profile);

  Future<Result<void>> deleteProfile(int index);
}
