import 'package:eddy_profile_book/common/utils/result_either.dart';
import 'package:eddy_profile_book/data/repositories/profiles_repository.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';

class AddProfileUseCase {
  final ProfilesRepository repository;

  AddProfileUseCase(this.repository);

  Future<Result<void>> call(Profile profile) async {
    return await repository.addProfile(profile);
  }
}
