import 'package:dartz/dartz.dart';
import 'package:kafil/core/models/failures.dart';
import 'package:kafil/features/home/domain/entities/countries.dart';
import 'package:kafil/features/home/domain/entities/services.dart';
import 'package:kafil/features/home/domain/use_cases/get_countries_use_case.dart';
import 'package:kafil/features/home/domain/use_cases/get_services_use_case.dart';

abstract class HomeRepository {
  Future<Either<Failure, Countries>> getCountries(GetCountriesParams params);

  Future<Either<Failure, Services>> getServices(GetServicesParams params);
}
