part of 'services_cubit.dart';

sealed class ServicesState {
  const ServicesState();
}

final class ServicesInitial extends ServicesState {}

final class ServicesLoaded extends ServicesState {
  final List<ServiceModel> models;

  const ServicesLoaded({required this.models});
}

final class FilteredServicesLoaded extends ServicesState {
  final List<ServiceModel> models;

  const FilteredServicesLoaded({required this.models});
}
