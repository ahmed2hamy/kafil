import 'package:flutter/material.dart';
import 'package:kafil/constants/constants.dart';

class CheckboxImageTextItem extends StatefulWidget {
  final String image;
  final String text;
  final bool? initiallyChecked;
  final void Function(bool, String) onSelected;

  const CheckboxImageTextItem({
    super.key,
    required this.image,
    required this.text,
    this.initiallyChecked,
    required this.onSelected,
  });

  @override
  State<CheckboxImageTextItem> createState() => _CheckboxImageTextItemState();
}

class _CheckboxImageTextItemState extends State<CheckboxImageTextItem> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initiallyChecked ?? false;
  }

  void _toggleCheckbox(bool? value) {
    widget.onSelected(value ?? _isChecked, widget.text);

    setState(() {
      _isChecked = !_isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.initiallyChecked != null
            ? Checkbox(value: _isChecked, onChanged: _toggleCheckbox)
            : const SizedBox() ,
        Image.asset(widget.image, width: 20, height: 20),
        const SizedBox(width: 10),
        Text(widget.text, style: kSubTitleTextStyle),
      ],
    );
  }
}
