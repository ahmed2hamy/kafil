part of 'constants.dart';

final ThemeData kAppThemeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: kPrimary900Color)
      .copyWith(primary: kPrimary900Color),
  fontFamily: kMontserratFontFamily,
  useMaterial3: true,
  inputDecorationTheme: kInputDecorationTheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: kDefaultButtonStyle,
  ),
);
