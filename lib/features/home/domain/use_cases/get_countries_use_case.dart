import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kafil/core/models/failures.dart';
import 'package:kafil/core/use_case/use_case.dart';
import 'package:kafil/features/home/domain/entities/countries.dart';
import 'package:kafil/features/home/domain/repositories/home_repository.dart';

class GetCountriesUseCase extends UseCase<Countries, GetCountriesParams> {
  final HomeRepository _homeRepository;

  const GetCountriesUseCase({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, Countries>> call(GetCountriesParams params) async {
    return await _homeRepository.getCountries(params);
  }
}

class GetCountriesParams extends Equatable {
  final int page;

  const GetCountriesParams({
    required this.page,
  });

  @override
  List<Object?> get props => [page];
}
