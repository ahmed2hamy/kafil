import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafil/core/use_case/use_case.dart';
import 'package:kafil/features/login/domain/entities/profile.dart';
import 'package:kafil/features/login/domain/use_cases/auto_login_use_case.dart';
import 'package:kafil/features/login/domain/use_cases/login_use_case.dart';
import 'package:kafil/features/login/domain/use_cases/logout_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final AutoLoginUseCase _autoLoginUseCase;
  final LogoutUseCase _logoutUseCase;

  LoginCubit({
    required LoginUseCase loginUseCase,
    required AutoLoginUseCase autoLoginUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _loginUseCase = loginUseCase,
        _autoLoginUseCase = autoLoginUseCase,
        _logoutUseCase = logoutUseCase,
        super(LoginInitialState());

  Future<void> login(LoginParams loginParams) async {
    emit(LoginLoadingState());
    final res = await _loginUseCase.call(loginParams);

    res.fold(
      (l) => emit(LoginErrorState(errorMessage: l.message)),
      (r) => emit(LoggedInState(profile: r)),
    );
  }

  Future<void> autoLogin() async {
    emit(LoginLoadingState());
    final res = await _autoLoginUseCase.call(NoParams());

    res.fold(
      (l) => emit(LoginErrorState(errorMessage: l.message)),
      (r) => r != null
          ? emit(LoggedInState(profile: r))
          : emit(LoginInitialState()),
    );
  }

  Future<void> logout() async {
    emit(LoginLoadingState());
    final res = await _logoutUseCase.call(NoParams());

    res.fold(
      (l) => emit(LoginErrorState(errorMessage: l.message)),
      (r) => emit(LoggedOutState()),
    );
  }
}
