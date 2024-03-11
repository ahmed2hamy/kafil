import 'package:flutter/material.dart';

class ChipsRadioOptionsWidget extends StatefulWidget {
  final List<String> options;
  final int? selectedIndex;
  final void Function(int)? onSelected;

  const ChipsRadioOptionsWidget({
    super.key,
    required this.options,
    this.selectedIndex,
    required this.onSelected,
  });

  @override
  State<ChipsRadioOptionsWidget> createState() =>
      _ChipsRadioOptionsWidgetState();
}

class _ChipsRadioOptionsWidgetState extends State<ChipsRadioOptionsWidget> {
  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return widget.selectedIndex != null
        ? Row(
          children: [
            ChoiceChip(
                label: Text(widget.options[widget.selectedIndex!]),
                selected: true,
                onSelected: (bool selected) {},
              ),
          ],
        )
        : Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: List<Widget>.generate(
              widget.options.length,
              (int index) {
                return ChoiceChip(
                  label: Text(widget.options[index]),
                  selected: _selectedValue == index,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedValue = selected ? index : null;
                      widget.onSelected != null
                          ? widget.onSelected!(index)
                          : null;
                    });
                  },
                );
              },
            ).toList(),
          );
  }
}
