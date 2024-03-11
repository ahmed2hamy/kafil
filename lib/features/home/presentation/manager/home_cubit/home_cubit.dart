import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/features/home/domain/entities/countries.dart';
import 'package:kafil/features/home/domain/entities/services.dart';
import 'package:kafil/features/home/domain/use_cases/get_countries_use_case.dart';
import 'package:kafil/features/home/domain/use_cases/get_services_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCountriesUseCase _getCountriesUseCase;
  final GetServicesUseCase _getServicesUseCase;

  HomeCubit({
    required GetCountriesUseCase getCountriesUseCase,
    required GetServicesUseCase getServicesUseCase,
  })  : _getCountriesUseCase = getCountriesUseCase,
        _getServicesUseCase = getServicesUseCase,
        super(HomeInitialState());

  Future<void> getCountries(int page) async {
    emit(HomeLoadingState());
    final res = await _getCountriesUseCase.call(GetCountriesParams(page: page));

    res.fold(
      (l) => emit(HomeErrorState(errorMessage: l.message)),
      (r) => emit(CountriesLoadedState(countries: r)),
    );
  }

  Future<void> getServices() async {
    emit(HomeLoadingState());
    final servicesMap = <String, Services>{};

    try {
      final servicesResult = await _getServicesUseCase
          .call(const GetServicesParams(isPopularServices: false));
      final popularServicesResult = await _getServicesUseCase
          .call(const GetServicesParams(isPopularServices: true));

      servicesResult.fold(
        (l) => throw Exception(l.message),
        (r) => servicesMap[kServicesString] = r,
      );

      popularServicesResult.fold(
        (l) => throw Exception(l.message),
        (r) => servicesMap[kPopularServicesString] = r,
      );

      emit(ServicesLoadedState(servicesMap: servicesMap));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }
}
