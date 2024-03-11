part of 'constants.dart';

final InputDecorationTheme kInputDecorationTheme = InputDecorationTheme(
  labelStyle: kDefaultTextStyle,
  floatingLabelStyle: kDefaultTextStyle,
  fillColor: kGrey50Color,
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16.0),
    borderSide: const BorderSide(
      color: kGrey50Color,
      width: 1.0,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16.0),
    borderSide: const BorderSide(
      color: kGrey50Color,
      width: 1.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16.0),
    borderSide: const BorderSide(
      color: kGrey50Color,
      width: 1.0,
    ),
  ),
);

final ButtonStyle kDefaultButtonStyle = ButtonStyle(
  textStyle: MaterialStatePropertyAll(kButtonDefaultTextStyle),
  backgroundColor: const MaterialStatePropertyAll(kPrimary900Color),
  foregroundColor: const MaterialStatePropertyAll(Colors.white),
  minimumSize: const MaterialStatePropertyAll(
    Size(double.maxFinite, double.minPositive),
  ),
  padding: const MaterialStatePropertyAll(
    EdgeInsets.symmetric(vertical: 18.0),
  ),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),
);
