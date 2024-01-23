import 'dart:async';

import 'package:eddy_profile_book/common/utils/event_bus.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/delete_profile_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/get_profiles_use_case.dart';
import 'package:eddy_profile_book/presentation/cubits/profiles/profiles_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilesCubit extends Cubit<ProfilesState> {
  final GetProfilesUseCase _getProfilesUseCase;
  final DeleteProfileUseCase _deleteProfileUseCase;
  late final StreamSubscription _profileAddedSubscription;

  ProfilesCubit(this._getProfilesUseCase, this._deleteProfileUseCase) : super(ProfilesInitial()) {
    _profileAddedSubscription = eventBus.on<ProfileAddedEvent>().listen((event) {
      getProfiles();
    });
  }

  @override
  close() async {
    _profileAddedSubscription.cancel();
    super.close();
  }

  getProfiles() async {
    var result = await _getProfilesUseCase();

    result.fold(
      onSuccess: (profiles) => emit(ProfilesLoaded(profiles ?? [])),
      onError: (failure) => emit(ProfilesError(failure.message)),
    );
  }

  deleteProfile(String profileId) async {
    var result = await _deleteProfileUseCase(profileId);

    result.fold(
      onSuccess: (_) {},
      onError: (failure) => emit(ProfilesError(failure.message)),
    );
  }
}
