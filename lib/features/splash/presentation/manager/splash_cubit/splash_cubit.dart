import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafil/core/use_case/use_case.dart';
import 'package:kafil/features/splash/domain/entities/app_dependencies.dart';
import 'package:kafil/features/splash/domain/use_cases/get_app_dependencies_use_case.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetAppDependenciesUseCase _getAppDependenciesUseCase;

  SplashCubit({required GetAppDependenciesUseCase getAppDependenciesUseCase})
      : _getAppDependenciesUseCase = getAppDependenciesUseCase,
        super(SplashInitialState());

  Future<void> getAppDependencies() async {
    emit(SplashLoadingState());
    final res = await _getAppDependenciesUseCase.call(NoParams());

    res.fold(
      (l) => emit(SplashErrorState(errorMessage: l.message)),
      (r) => emit(AppDependenciesLoadedState(appDependencies: r)),
    );
  }
}
