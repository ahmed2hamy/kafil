import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kafil/constants/constants.dart';

class EditableChipField extends StatefulWidget {
  final List<String> values;
  final String labelText;
  final void Function(List<String>)? onValuesChanged;
  final List<String>? selectedValues;

  const EditableChipField({
    super.key,
    required this.values,
    required this.labelText,
    required this.onValuesChanged,
    this.selectedValues,
  });

  @override
  EditableChipFieldState createState() => EditableChipFieldState();
}

class EditableChipFieldState extends State<EditableChipField> {
  final FocusNode _chipFocusNode = FocusNode();
  late List<String> _selectedValues;
  List<String> _suggestions = <String>[];

  @override
  void initState() {
    super.initState();
    _selectedValues = widget.selectedValues ?? <String>[];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ChipsInput<String>(
          values: _selectedValues,
          labelText: widget.labelText,
          strutStyle: const StrutStyle(fontSize: 15),
          onChanged: widget.selectedValues != null ? null : _onChanged,
          onSubmitted: widget.selectedValues != null ? null : _onSubmitted,
          chipBuilder: _chipBuilder,
          onTextChanged:
              widget.selectedValues != null ? null : _onSearchChanged,
        ),
        if (_suggestions.isNotEmpty)
          SuggestionWidget(
            _suggestions[0],
            onTap: _selectSuggestion,
          ),
      ],
    );
  }

  Future<void> _onSearchChanged(String value) async {
    final List<String> results = await _suggestionCallback(value);
    setState(() {
      _suggestions = results
          .where((String value) => !_selectedValues.contains(value))
          .toList();
    });
  }

  Widget _chipBuilder(BuildContext context, String value) {
    return InputChipItem(
      value: value,
      onDeleted: widget.selectedValues != null ? null : _onChipDeleted,
      onSelected: _onChipTapped,
    );
  }

  void _selectSuggestion(String value) {
    setState(() {
      _selectedValues.add(value);
      _suggestions = <String>[];
      if (widget.onValuesChanged != null) {
        widget.onValuesChanged!(_selectedValues);
      }
    });
  }

  void _onChipTapped(String value) {}

  void _onChipDeleted(String value) {
    setState(() {
      _selectedValues.remove(value);
      _suggestions = <String>[];
      if (widget.onValuesChanged != null) {
        widget.onValuesChanged!(_selectedValues);
      }
    });
  }

  void _onSubmitted(String text) {
    if (text.trim().isEmpty) {
      _chipFocusNode.unfocus();
      setState(() {
        _selectedValues = <String>[];
      });
    }
  }

  void _onChanged(List<String> data) {
    setState(() {
      _selectedValues = data;
      if (widget.onValuesChanged != null) {
        widget.onValuesChanged!(_selectedValues);
      }
    });
  }

  FutureOr<List<String>> _suggestionCallback(String text) {
    if (text.isNotEmpty) {
      return widget.values.where((String value) {
        return value.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }
    return const <String>[];
  }
}

class ChipsInput<T> extends StatefulWidget {
  const ChipsInput({
    super.key,
    required this.values,
    this.decoration = const InputDecoration(),
    this.style,
    this.strutStyle,
    required this.chipBuilder,
    required this.onChanged,
    this.onChipTapped,
    this.onSubmitted,
    this.onTextChanged,
    this.labelText,
  });

  final List<T> values;
  final InputDecoration decoration;
  final TextStyle? style;
  final StrutStyle? strutStyle;

  final ValueChanged<List<T>>? onChanged;
  final ValueChanged<T>? onChipTapped;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onTextChanged;
  final String? labelText;

  final Widget Function(BuildContext context, T data) chipBuilder;

  @override
  ChipsInputState<T> createState() => ChipsInputState<T>();
}

class ChipsInputState<T> extends State<ChipsInput<T>> {
  @visibleForTesting
  late final ChipsInputEditingController<T> controller;

  String _previousText = '';
  TextSelection? _previousSelection;

  @override
  void initState() {
    super.initState();

    controller = ChipsInputEditingController<T>(
      <T>[...widget.values],
      widget.chipBuilder,
    );
    controller.addListener(_textListener);
  }

  @override
  void dispose() {
    controller.removeListener(_textListener);
    controller.dispose();

    super.dispose();
  }

  void _textListener() {
    final String currentText = controller.text;

    if (_previousSelection != null) {
      final int currentNumber = countReplacements(currentText);
      final int previousNumber = countReplacements(_previousText);

      final int cursorEnd = _previousSelection!.extentOffset;
      final int cursorStart = _previousSelection!.baseOffset;

      final List<T> values = <T>[...widget.values];

      // If the current number and the previous number of replacements are different, then
      // the user has deleted the InputChip using the keyboard. In this case, we trigger
      // the onChanged callback. We need to be sure also that the current number of
      // replacements is different from the input chip to avoid double-deletion.
      if (currentNumber < previousNumber && currentNumber != values.length) {
        if (cursorStart == cursorEnd) {
          values.removeRange(cursorStart - 1, cursorEnd);
        } else {
          if (cursorStart > cursorEnd) {
            values.removeRange(cursorEnd, cursorStart);
          } else {
            values.removeRange(cursorStart, cursorEnd);
          }
        }
        if (widget.onChanged != null) widget.onChanged!(values);
      }
    }

    _previousText = currentText;
    _previousSelection = controller.selection;
  }

  static int countReplacements(String text) {
    return text.codeUnits
        .where(
            (int u) => u == ChipsInputEditingController.kObjectReplacementChar)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    controller.updateValues(<T>[...widget.values]);

    return IntrinsicHeight(
      child: TextField(
        expands: true,
        maxLines: null,
        readOnly: widget.onChanged == null,
        decoration: InputDecoration(
          labelText: widget.labelText,
        ),
        textInputAction: TextInputAction.done,
        style: widget.style,
        strutStyle: widget.strutStyle,
        controller: controller,
        onChanged: (String value) =>
            widget.onTextChanged?.call(controller.textWithoutReplacements),
        onSubmitted: (String value) =>
            widget.onSubmitted?.call(controller.textWithoutReplacements),
      ),
    );
  }
}

class ChipsInputEditingController<T> extends TextEditingController {
  ChipsInputEditingController(this.values, this.chipBuilder)
      : super(
          text: String.fromCharCode(kObjectReplacementChar) * values.length,
        );

  // This constant character acts as a placeholder in the TextField text value.
  // There will be one character for each of the InputChip displayed.
  static const int kObjectReplacementChar = 0xFFFE;

  List<T> values;

  final Widget Function(BuildContext context, T data) chipBuilder;

  /// Called whenever chip is either added or removed
  /// from the outside the context of the text field.
  void updateValues(List<T> values) {
    if (values.length != this.values.length) {
      final String char = String.fromCharCode(kObjectReplacementChar);
      final int length = values.length;
      value = TextEditingValue(
        text: char * length,
        selection: TextSelection.collapsed(offset: length),
      );
      this.values = values;
    }
  }

  String get textWithoutReplacements {
    final String char = String.fromCharCode(kObjectReplacementChar);
    return text.replaceAll(RegExp(char), '');
  }

  String get textWithReplacements => text;

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final Iterable<WidgetSpan> chipWidgets =
        values.map((T v) => WidgetSpan(child: chipBuilder(context, v)));

    return TextSpan(
      style: style,
      children: <InlineSpan>[
        ...chipWidgets,
        if (textWithoutReplacements.isNotEmpty)
          TextSpan(text: textWithoutReplacements)
      ],
    );
  }
}

class SuggestionWidget extends StatelessWidget {
  const SuggestionWidget(this.value, {super.key, this.onTap});

  final String value;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ObjectKey(value),
      leading: CircleAvatar(
        child: Text(
          value[0].toUpperCase(),
        ),
      ),
      title: Text(value),
      onTap: () => onTap?.call(value),
    );
  }
}

class InputChipItem extends StatelessWidget {
  const InputChipItem({
    super.key,
    required this.value,
    required this.onDeleted,
    required this.onSelected,
  });

  final String value;
  final ValueChanged<String>? onDeleted;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3.0),
      child: InputChip(
        key: ObjectKey(value),
        label: Text(value, style: kPrimaryTextStyle),
        backgroundColor: kPrimary100Color,
        side: const BorderSide(width: 0.0, color: kPrimary100Color),
        deleteIconColor: kPrimary900Color,
        onDeleted: onDeleted != null ? () => onDeleted!(value) : null,
        onSelected: (bool isSelected) => onSelected(value),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.all(2.0),
      ),
    );
  }
}
