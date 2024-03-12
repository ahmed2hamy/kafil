import 'package:flutter/material.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/widgets/circle_icon_button.dart';

class SalaryPicker extends StatefulWidget {
  final int minSalary;
  final int maxSalary;
  final int initialSalary;
  final int? salary;
  final void Function(int) onSalaryChanged;

  const SalaryPicker({
    super.key,
    this.minSalary = 100,
    this.maxSalary = 1000,
    this.initialSalary = 500,
    required this.salary,
    required this.onSalaryChanged,
  });

  @override
  State<SalaryPicker> createState() => _SalaryPickerState();
}

class _SalaryPickerState extends State<SalaryPicker> {
  final int _interval = 10;
  late int _salary;

  @override
  void initState() {
    super.initState();
    _salary = widget.salary ?? widget.initialSalary;
    widget.onSalaryChanged(_salary);
  }

  void _decrementSalary() {
    if (_salary > widget.minSalary) {
      setState(() {
        _salary -= _interval;

        widget.onSalaryChanged(_salary);
      });
    }
  }

  void _incrementSalary() {
    if (_salary < widget.maxSalary) {
      setState(() {
        _salary += _interval;

        widget.onSalaryChanged(_salary);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: kGrey50Color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          widget.salary != null
              ? const SizedBox()
              : CircleIconButton(
                  icon: Icons.remove,
                  onPressed: _decrementSalary,
                ),
          Text('$kSARString $_salary'),
          widget.salary != null
              ? const SizedBox()
              : CircleIconButton(
                  icon: Icons.add,
                  onPressed: _incrementSalary,
                ),
        ],
      ),
    );
  }
}
