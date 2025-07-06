part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserInfoModel user;
  ProfileLoaded(this.user);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final String message;
  ProfileUpdated(this.message);
}
