import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/data/repositories/profiles/profiles_repository.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';

class DeleteProfileUseCase {
  final ProfilesRepository repository;

  DeleteProfileUseCase(this.repository);

  Future<Result<void>> call(String profileId) async {
    return await repository.deleteProfile(profileId);
  }
}
