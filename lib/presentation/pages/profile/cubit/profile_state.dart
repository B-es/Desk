part of 'profile_cubit.dart';

sealed class ProfileState {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final List<ServiceModel> models;
  final String timestamp = DateTime.now().toString();

  ProfileLoaded({required this.models});
}

final class OrderedProfileLoaded extends ProfileState {
  final List<ServiceModel> models;
  final String timestamp = DateTime.now().toString();

  OrderedProfileLoaded({required this.models});
}

final class UnloggedProfileLoaded extends ProfileState {
  final String timestamp = DateTime.now().toString();

  UnloggedProfileLoaded();
}
