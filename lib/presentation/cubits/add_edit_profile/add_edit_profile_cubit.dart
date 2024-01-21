import 'dart:async';

import 'package:eddy_profile_book/data/data_sources/local_data/profiles_storage.dart';
import 'package:eddy_profile_book/domain/entities/profile.dart';
import 'package:eddy_profile_book/presentation/cubits/add_edit_profile/add_edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditProfileCubit extends Cubit<AddEditProfileState> {
  final ProfilesStorage _profilesStorage;

  AddEditProfileCubit(this._profilesStorage) : super(AddEditProfileInitial());

  Future<void> addProfile(Profile profile) async {
    try {
      await _profilesStorage.addProfile(profile);
      emit(AddEditProfileSuccess());
    } catch (e) {
      emit(AddEditProfileError(e.toString()));
    }
  }

  Future<void> editProfile(int index, Profile profile) async {
    try {
      await _profilesStorage.updateProfile(index, profile);
      emit(AddEditProfileSuccess());
    } catch (e) {
      emit(AddEditProfileError(e.toString()));
    }
  }

// Future<void> deleteProfile(int index) async {
//   try {
//     await _profilesStorage.deleteProfile(index);
//     emit(AddEditProfileSuccess());
//   } catch (e) {
//     emit(AddEditProfileError(e.toString()));
//   }
// }
}
