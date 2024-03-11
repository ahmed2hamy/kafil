import 'package:flutter/material.dart';
import 'package:kafil/constants/constants.dart';

class IconContainer extends StatelessWidget {
  final IconData? iconData;
  final bool? isSelected;

  const IconContainer({
    super.key,
    this.iconData,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isSelected == true ? kPrimary900Color : null,
        borderRadius: BorderRadius.circular(7.0),
        border: (Border.all(color: kGrey200Color, width: 1.5)),
      ),
      child: iconData != null ? Icon(iconData, size: 16.0) : null,
    );
  }
}
