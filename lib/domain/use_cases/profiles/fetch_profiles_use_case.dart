import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/data/repositories/profiles_repository.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';

class FetchProfilesUseCase {
  final ProfilesRepository repository;

  FetchProfilesUseCase(this.repository);

  Future<Result<Stream<Iterable<Profile>>>> call() async {
    return repository.fetchProfiles();
  }
}
