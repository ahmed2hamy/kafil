import 'package:flutter/material.dart';
import 'package:kafil/constants/constants.dart';

class PaginationNumber extends StatelessWidget {
  final int number;
  final bool isSelected;
  final ValueChanged<int> onSelectPage;

  const PaginationNumber({
    super.key,
    required this.number,
    required this.isSelected,
    required this.onSelectPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : null,
          backgroundColor: isSelected ? Theme.of(context).primaryColor : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
            side: const BorderSide(color: kGrey200Color, width: 1.5),
          ),
        ),
        onPressed: () => onSelectPage(number),
        child: Text(
          '$number',
          style: isSelected ? kButtonDefaultTextStyle : kSubTitleTextStyle,
        ),
      ),
    );
  }
}