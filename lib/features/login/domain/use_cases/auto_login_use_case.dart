import 'package:dartz/dartz.dart';
import 'package:kafil/core/models/failures.dart';
import 'package:kafil/core/use_case/use_case.dart';
import 'package:kafil/features/login/domain/entities/profile.dart';
import 'package:kafil/features/login/domain/repositories/login_repository.dart';

class AutoLoginUseCase extends UseCase<Profile?, NoParams> {
  final LoginRepository _loginRepository;

  const AutoLoginUseCase({
    required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  @override
  Future<Either<Failure, Profile?>> call(NoParams params) async {
    return await _loginRepository.autoLogin(params);
  }
}