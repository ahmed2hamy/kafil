import 'package:dartz/dartz.dart';
import 'package:kafil/core/models/failures.dart';
import 'package:kafil/core/use_case/use_case.dart';
import 'package:kafil/features/login/domain/entities/profile.dart';
import 'package:kafil/features/login/domain/use_cases/login_use_case.dart';

abstract class LoginRepository {
  Future<Either<Failure, Profile>> login(LoginParams params);

  Future<Either<Failure, Profile?>> autoLogin(NoParams params);

  Future<Either<Failure, bool>> logout(NoParams noParams);
}
