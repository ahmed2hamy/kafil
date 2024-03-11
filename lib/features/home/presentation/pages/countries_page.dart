import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/widgets/app_loading_widget.dart';
import 'package:kafil/core/widgets/dialogs.dart';
import 'package:kafil/core/widgets/kafil_app_bar.dart';
import 'package:kafil/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:kafil/features/home/presentation/widgets/countries_list_view.dart';
import 'package:kafil/features/home/presentation/widgets/countries_page_header_row.dart';
import 'package:kafil/features/home/presentation/widgets/pagination_bar.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({super.key});

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  static const int _totalData = 100;
  static const int _itemsPerPage = 10;
  int _currentPage = 1;

  late final int _totalPages;

  @override
  void initState() {
    super.initState();
    _totalPages = (_totalData / _itemsPerPage).ceil();
    context.read<HomeCubit>().getCountries(_currentPage);
  }

  void _selectPage(int number) {
    setState(() {
      _currentPage = number;
      context.read<HomeCubit>().getCountries(_currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KafilAppBar.appBar(context, title: kCountriesString),
      backgroundColor: kGrey50Color,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CountriesPageHeaderRow(),
            Expanded(
              child: BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state is HomeErrorState) {
                    Dialogs.showErrorMessage(context,
                        message: state.errorMessage);
                  }
                },
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return const AppLoadingWidget();
                  } else if (state is CountriesLoadedState) {
                    return CountriesListView(
                        pageData: state.countries.data ?? []);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            PaginationBar(
              currentPage: _currentPage,
              totalPages: _totalPages,
              onSelectPage: _selectPage,
            ),
          ],
        ),
      ),
    );
  }
}
