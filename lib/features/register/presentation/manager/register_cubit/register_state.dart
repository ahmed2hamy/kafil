part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitialState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoadingState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisteredState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterErrorState extends RegisterState {
  final String? errorMessage;

  const RegisterErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
