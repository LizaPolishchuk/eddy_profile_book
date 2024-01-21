import 'package:eddy_profile_book/domain/entities/profile.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class ProfilesState {}

class ProfilesInitial extends ProfilesState {}

class ProfilesLoading extends ProfilesState {}

class ProfilesLoaded extends ProfilesState {
  final List<Profile> profiles;

  ProfilesLoaded(this.profiles);
}

class ProfilesError extends ProfilesState {
  final String error;

  ProfilesError(this.error);
}
