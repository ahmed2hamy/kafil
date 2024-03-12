import 'package:dio/dio.dart';
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

  Future<void> register(FormData requestFormData) async {
    emit(RegisterLoadingState());
    final res = await _registerUseCase.call(RegisterParams(requestFormData: requestFormData));

    res.fold(
      (l) => emit(RegisterErrorState(errorMessage: l.message)),
      (r) => emit(RegisteredState()),
    );
  }
}
