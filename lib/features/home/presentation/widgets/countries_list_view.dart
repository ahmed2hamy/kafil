
import 'package:flutter/material.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/features/home/domain/entities/countries.dart';

class CountriesListView extends StatelessWidget {
  const CountriesListView({
    super.key,
    required this.pageData,
  });

  final List<CountriesData> pageData;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: pageData.length,
      itemBuilder: (_, index) => ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(child: Text(pageData[index].name ??'', maxLines: 5,)),
            Expanded(child: Text(pageData[index].capital ?? '', maxLines: 5,)),
          ],
        ),
      ),
      separatorBuilder: (_, __) => const Divider(
        height: 1,
        color: kGrey100Color,
      ),
    );
  }
}