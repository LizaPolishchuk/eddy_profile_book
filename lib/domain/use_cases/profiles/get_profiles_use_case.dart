import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/data/repositories/profiles/profiles_repository.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';

class GetProfilesUseCase {
  final ProfilesRepository repository;

  GetProfilesUseCase(this.repository);

  Future<Result<List<Profile>>> call() async {
    return repository.getProfiles();
  }
}
