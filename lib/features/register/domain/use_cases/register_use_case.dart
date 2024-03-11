import 'package:dartz/dartz.dart';
import 'package:kafil/core/models/base_model.dart';
import 'package:kafil/core/models/failures.dart';
import 'package:kafil/core/use_case/use_case.dart';
import 'package:kafil/features/register/domain/entities/register_params.dart';
import 'package:kafil/features/register/domain/repositories/register_repository.dart';

class RegisterUseCase extends UseCase<BaseModel, RegisterParams> {
  final RegisterRepository _registerRepository;

  const RegisterUseCase({
    required RegisterRepository registerRepository,
  }) : _registerRepository = registerRepository;

  @override
  Future<Either<Failure, BaseModel>> call(RegisterParams params) async {
    return await _registerRepository.register(params);
  }
}
