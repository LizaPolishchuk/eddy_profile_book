import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/data/repositories/profiles_repository.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';

class UpdateProfileUseCase {
  final ProfilesRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Result<void>> call(int index, Profile profile) async {
    return await repository.updateProfile(index, profile);
  }
}
