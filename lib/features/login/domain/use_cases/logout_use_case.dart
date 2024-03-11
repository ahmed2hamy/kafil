import 'package:dartz/dartz.dart';
import 'package:kafil/core/models/failures.dart';
import 'package:kafil/core/use_case/use_case.dart';
import 'package:kafil/features/login/domain/repositories/login_repository.dart';

class LogoutUseCase extends UseCase<bool, NoParams> {
  final LoginRepository _loginRepository;

  const LogoutUseCase({
    required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await _loginRepository.logout(params);
  }
}
