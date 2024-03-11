import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kafil/core/models/failures.dart';
import 'package:kafil/core/use_case/use_case.dart';
import 'package:kafil/features/home/domain/entities/services.dart';
import 'package:kafil/features/home/domain/repositories/home_repository.dart';

class GetServicesUseCase extends UseCase<Services, GetServicesParams> {
  final HomeRepository _homeRepository;

  const GetServicesUseCase({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, Services>> call(GetServicesParams params) async {
    return await _homeRepository.getServices(params);
  }
}

class GetServicesParams extends Equatable {
  final bool isPopularServices;

  const GetServicesParams({
    this.isPopularServices = false,
  });

  @override
  List<Object?> get props => [isPopularServices];
}
