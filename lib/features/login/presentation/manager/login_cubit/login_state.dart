part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoggedInState extends LoginState {
  final Profile profile;

  const LoggedInState({required this.profile});

  @override
  List<Object> get props => [profile];
}

class LoggedOutState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginErrorState extends LoginState {
  final String? errorMessage;

  const LoginErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
