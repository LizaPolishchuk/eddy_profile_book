import 'dart:async';

import 'package:eddy_profile_book/data/data_sources/local_data/profiles_storage.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';
import 'package:eddy_profile_book/presentation/cubits/profiles/profiles_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilesCubit extends Cubit<ProfilesState> {
  final ProfilesStorage _profilesStorage;

  ProfilesCubit(this._profilesStorage) : super(ProfilesInitial()) {
    _profilesStorage.getProfiles().addListener(() {
      emit(ProfilesLoaded(_profilesStorage.getProfiles().value.values.toList()));
    });
  }

  Future<void> getProfiles() async {
    try {
      emit(ProfilesLoaded(_profilesStorage.getProfiles().value.values.toList()));
    } catch (e) {
      emit(ProfilesError(e.toString()));
    }
  }

  Future<void> addProfile(Profile profile) async {
    try {
      _profilesStorage.addProfile(profile);
    } catch (e) {
      emit(ProfilesError(e.toString()));
    }
  }

  Future<void> updateProfile(int index, Profile profile) async {
    try {
      _profilesStorage.updateProfile(index, profile);
    } catch (e) {
      emit(ProfilesError(e.toString()));
    }
  }

  Future<void> deleteProfile(int index) async {
    try {
      _profilesStorage.deleteProfile(index);
    } catch (e) {
      emit(ProfilesError(e.toString()));
    }
  }
}
