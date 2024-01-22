import 'dart:async';

import 'package:eddy_profile_book/data/data_sources/local_data/profiles_storage.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/delete_profile_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/get_profiles_use_case.dart';
import 'package:eddy_profile_book/presentation/cubits/profiles/profiles_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilesCubit extends Cubit<ProfilesState> {
  final GetProfilesUseCase _getProfilesUseCase;
  final DeleteProfileUseCase _deleteProfileUseCase;

  ProfilesCubit(this._getProfilesUseCase, this._deleteProfileUseCase) : super(ProfilesInitial()) {
    // _profilesStorage.getProfiles().addListener(() {
    //   emit(ProfilesLoaded(_profilesStorage.getProfiles().value.values.toList()));
    // });
  }

  getProfiles() async {
    var result = await _getProfilesUseCase();

    result.fold(
      data: (profiles) => emit(ProfilesLoaded(profiles)),
      error: (failure) => emit(ProfilesError(failure.message)),
    );
  }

  deleteProfile(int index) async {
    var result = await _deleteProfileUseCase(index);

    result.fold(
      data: (_) => emit(ProfileDeleted()),
      error: (failure) => emit(ProfilesError(failure.message)),
    );
  }
}
