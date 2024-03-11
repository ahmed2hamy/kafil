import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kafil/core/models/failures.dart';
import 'package:kafil/core/use_case/use_case.dart';
import 'package:kafil/features/login/domain/entities/profile.dart';
import 'package:kafil/features/login/domain/repositories/login_repository.dart';

class LoginUseCase extends UseCase<Profile, LoginParams> {
  final LoginRepository _loginRepository;

  const LoginUseCase({
    required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  @override
  Future<Either<Failure, Profile>> call(LoginParams params) async {
    return await _loginRepository.login(params);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;
  final bool rememberMe;

  const LoginParams({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  @override
  List<Object?> get props => [email, password, rememberMe];
}
