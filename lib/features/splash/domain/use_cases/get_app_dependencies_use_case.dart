import 'package:dartz/dartz.dart';
import 'package:kafil/core/models/failures.dart';
import 'package:kafil/core/use_case/use_case.dart';
import 'package:kafil/features/splash/domain/entities/app_dependencies.dart';
import 'package:kafil/features/splash/domain/repositories/splash_repository.dart';

class GetAppDependenciesUseCase extends UseCase<AppDependencies, NoParams> {
  final SplashRepository _splashRepository;

  const GetAppDependenciesUseCase({
    required SplashRepository splashRepository,
  }) : _splashRepository = splashRepository;

  @override
  Future<Either<Failure, AppDependencies>> call(NoParams params) async {
    return await _splashRepository.getAppDependencies();
  }
}
