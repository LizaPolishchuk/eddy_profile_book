import 'dart:async';
import 'package:eddy_profile_book/domain/entities/profile.dart';
import 'package:eddy_profile_book/domain/use_cases/profiles/set_profile_use_case.dart';
import 'package:eddy_profile_book/presentation/cubits/add_edit_profile/add_edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditProfileCubit extends Cubit<AddEditProfileState> {
  final SetProfileUseCase _setProfileUseCase;

  AddEditProfileCubit(this._setProfileUseCase) : super(AddEditProfileInitial());

  Future<void> setProfile(Profile profile) async {
    var result = await _setProfileUseCase(profile);

    result.fold(
      data: (_) => emit(AddEditProfileSuccess()),
      error: (failure) => emit(AddEditProfileError(failure.message)),
    );
  }
}
