part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeErrorState extends HomeState {
  final String? errorMessage;

  const HomeErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class CountriesLoadedState extends HomeState {
  final Countries countries;

  const CountriesLoadedState({required this.countries});

  @override
  List<Object> get props => [countries];
}

class ServicesLoadedState extends HomeState {
  final Map<String, Services> servicesMap;

  const ServicesLoadedState({required this.servicesMap});

  @override
  List<Object> get props => [servicesMap];
}
