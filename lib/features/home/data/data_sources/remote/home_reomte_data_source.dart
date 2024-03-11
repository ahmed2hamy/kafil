import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/models/exception.dart';
import 'package:kafil/core/network/network_client.dart';
import 'package:kafil/features/home/data/models/countries_model.dart';
import 'package:kafil/features/home/data/models/services_model.dart';
import 'package:kafil/features/home/domain/entities/countries.dart';
import 'package:kafil/features/home/domain/entities/services.dart';
import 'package:kafil/features/home/domain/use_cases/get_countries_use_case.dart';
import 'package:kafil/features/home/domain/use_cases/get_services_use_case.dart';

abstract class HomeRemoteDataSource {
  Future<Countries> getCountries(GetCountriesParams params);

  Future<Services> getServices(GetServicesParams params);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final NetworkClient _networkClient;

  const HomeRemoteDataSourceImpl({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;

  @override
  Future<Countries> getCountries(GetCountriesParams params) async {
    try {
      Map<String, dynamic> json = await _networkClient.get(
        Apis.countries,
        queryParameters: {
          'page': params.page,
        },
      );

      return CountriesModel.fromJson(json);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Services> getServices(GetServicesParams params) async {
    try {
      Map<String, dynamic> json = await _networkClient.get(
        params.isPopularServices ? Apis.popularServices : Apis.services,
      );

      return ServicesModel.fromJson(json);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
