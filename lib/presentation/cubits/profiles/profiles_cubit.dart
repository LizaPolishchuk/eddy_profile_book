import 'package:eddy_profile_book/domain/use_cases/profiles/delete_profile_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/fetch_profiles_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/get_profiles_use_case.dart';
import 'package:eddy_profile_book/presentation/cubits/profiles/profiles_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilesCubit extends Cubit<ProfilesState> {
  final GetProfilesUseCase _getProfilesUseCase;
  final DeleteProfileUseCase _deleteProfileUseCase;
  final FetchProfilesUseCase _fetchProfilesUseCase;

  ProfilesCubit(this._getProfilesUseCase, this._deleteProfileUseCase, this._fetchProfilesUseCase)
      : super(ProfilesInitial());

  fetchProfiles() async {
    var result = await _fetchProfilesUseCase();

    result.fold(
      data: (profilesStream) {
        profilesStream.listen((profiles) {
          emit(ProfilesLoaded(profiles.toList()));
        });
      },
      error: (failure) => emit(ProfilesError(failure.message)),
    );
  }

  getProfiles() async {
    var result = await _getProfilesUseCase();

    result.fold(
      data: (profiles) => emit(ProfilesLoaded(profiles)),
      error: (failure) => emit(ProfilesError(failure.message)),
    );
  }

  deleteProfile(String profileId) async {
    var result = await _deleteProfileUseCase(profileId);

    result.fold(
      data: (_) => emit(ProfileDeleted()),
      error: (failure) => emit(ProfilesError(failure.message)),
    );
  }
}
