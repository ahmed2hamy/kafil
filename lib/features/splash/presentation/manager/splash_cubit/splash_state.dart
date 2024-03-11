part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitialState extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashLoadingState extends SplashState {
  @override
  List<Object> get props => [];
}

class AppDependenciesLoadedState extends SplashState {
  final AppDependencies appDependencies;

  const AppDependenciesLoadedState({required this.appDependencies});

  @override
  List<Object> get props => [appDependencies];
}

class SplashErrorState extends SplashState {
  final String? errorMessage;

  const SplashErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
