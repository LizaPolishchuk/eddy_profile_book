import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/data/repositories/profiles/profiles_repository.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';

class SetProfileUseCase {
  final ProfilesRepository repository;

  SetProfileUseCase(this.repository);

  Future<Result<void>> call(Profile profile) async {
    return await repository.setProfile(profile);
  }
}
