import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';

abstract class ProfilesRepository {
  Result<List<Profile>> getProfiles();

  Result<Stream<Iterable<Profile>>> fetchProfiles();

  Future<Result<void>> setProfile(Profile profile);

  Future<Result<void>> deleteProfile(String profileId);
}
