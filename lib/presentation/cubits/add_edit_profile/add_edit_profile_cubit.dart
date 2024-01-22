import 'dart:async';
import 'package:eddy_profile_book/domain/entities/profile.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/add_profile_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/update_profile_use_case.dart';
import 'package:eddy_profile_book/presentation/cubits/add_edit_profile/add_edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditProfileCubit extends Cubit<AddEditProfileState> {
  final AddProfileUseCase _addProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  AddEditProfileCubit(this._addProfileUseCase, this._updateProfileUseCase) : super(AddEditProfileInitial());

  Future<void> addProfile(Profile profile) async {
    var result = await _addProfileUseCase(profile);

    result.fold(
      data: (_) => emit(AddEditProfileSuccess()),
      error: (failure) => emit(AddEditProfileError(failure.message)),
    );
  }

  Future<void> editProfile(int index, Profile profile) async {
    var result = await _updateProfileUseCase(index, profile);

    result.fold(
      data: (_) => emit(AddEditProfileSuccess()),
      error: (failure) => emit(AddEditProfileError(failure.message)),
    );
  }
}
