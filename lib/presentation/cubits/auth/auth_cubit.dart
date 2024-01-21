import 'package:eddy_profile_book/data/local_data/local_storage.dart';
import 'package:eddy_profile_book/presentation/cubits/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LocalStorage _localStorage;

  AuthCubit(this._localStorage) : super(SignInInitial());

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      // Simulate a network request
      await Future.delayed(Duration(seconds: 2));

      var savedEmail = _localStorage.getUserEmail();
      var savedPassword = _localStorage.getUserPassword();

      if (savedEmail != email || savedPassword != password) {
        emit(const AuthFailure("Invalid login or password!"));
        return;
      }

      _localStorage.setIsUserLoggedIn(true);
      emit(SignInSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      // Simulate a network request
      await Future.delayed(Duration(seconds: 2));

      var savedEmail = _localStorage.getUserEmail();
      if (savedEmail == email) {
        emit(const AuthFailure("This login is already taken"));
        return;
      }

      _localStorage.setUserEmail(email);
      _localStorage.setUserPassword(password);
      _localStorage.setIsUserLoggedIn(true);
      emit(SignUpSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      _localStorage.setIsUserLoggedIn(false);
      emit(SignOutSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
