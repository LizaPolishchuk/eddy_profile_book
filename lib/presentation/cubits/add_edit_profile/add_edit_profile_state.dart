import 'package:flutter/widgets.dart';

//todo create base state instance
@immutable
abstract class AddEditProfileState {}

class AddEditProfileInitial extends AddEditProfileState {}

class AddEditProfileLoading extends AddEditProfileState {}

class AddEditProfileSuccess extends AddEditProfileState {}

class AddEditProfileError extends AddEditProfileState {
  final String error;

  AddEditProfileError(this.error);
}
