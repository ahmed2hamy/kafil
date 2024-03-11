import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafil/features/register/domain/entities/register_params.dart';
import 'package:kafil/features/register/domain/use_cases/register_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit({
    required RegisterUseCase registerUseCase,
  })  : _registerUseCase = registerUseCase,
        super(RegisterInitialState());

  Future<void> register(RegisterParams registerParams) async {
    emit(RegisterLoadingState());
    final res = await _registerUseCase.call(registerParams);

    res.fold(
      (l) => emit(RegisterErrorState(errorMessage: l.message)),
      (r) => emit(RegisteredState()),
    );
  }
}
