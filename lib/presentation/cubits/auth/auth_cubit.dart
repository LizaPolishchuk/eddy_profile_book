import 'package:eddy_profile_book/domain/use_cases/auth/sign_in_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/auth/sign_out_use_case.dart';
import 'package:eddy_profile_book/domain/use_cases/auth/sign_up_use_case.dart';
import 'package:eddy_profile_book/presentation/cubits/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;

  AuthCubit(this._signInUseCase, this._signUpUseCase, this._signOutUseCase) : super(SignInInitial());

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());

    var result = await _signInUseCase(email, password);
    result.fold(
      data: (profiles) => emit(SignInSuccess()),
      error: (failure) => emit(AuthFailure(failure.message)),
    );
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());

    var result = await _signUpUseCase(email, password);
    result.fold(
      data: (profiles) => emit(SignUpSuccess()),
      error: (failure) => emit(AuthFailure(failure.message)),
    );
  }

  Future<void> signOut() async {
    var result = await _signOutUseCase();
    result.fold(
      data: (profiles) => emit(SignInSuccess()),
      error: (failure) => emit(AuthFailure(failure.message)),
    );
  }
}
