import 'package:flutter/material.dart';
import 'package:kafil/constants/constants.dart';

class CountriesPageHeaderRow extends StatelessWidget {
  const CountriesPageHeaderRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(kCountryString),
          Text(kCapitalString),
        ],
      ),
    );
  }
}
