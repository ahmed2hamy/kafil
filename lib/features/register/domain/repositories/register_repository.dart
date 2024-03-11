import 'package:dartz/dartz.dart';
import 'package:kafil/core/models/base_model.dart';
import 'package:kafil/core/models/failures.dart';
import 'package:kafil/features/register/domain/entities/register_params.dart';

abstract class RegisterRepository {
  Future<Either<Failure, BaseModel>> register(RegisterParams params);
}
