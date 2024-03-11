import 'package:dartz/dartz.dart';
import 'package:kafil/core/models/failures.dart';
import 'package:kafil/features/splash/domain/entities/app_dependencies.dart';

abstract class SplashRepository {
  Future<Either<Failure, AppDependencies>> getAppDependencies();
}
