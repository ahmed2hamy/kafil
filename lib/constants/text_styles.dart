part of 'constants.dart';

const String kMontserratFontFamily = 'Montserrat';

TextStyle baseTextStyle({
  Color color = kGrey500Color,
  double fontSize = 12.0,
  String fontFamily = kMontserratFontFamily,
  FontWeight? fontWeight = FontWeight.normal,
}) =>
    TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
    );

TextStyle kDefaultTextStyle = baseTextStyle();

TextStyle kButtonDefaultTextStyle = baseTextStyle(
  color: Colors.white,
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
);

TextStyle kPrimaryTextStyle = baseTextStyle(color: kPrimary900Color);

TextStyle kPrimaryBoldTextStyle = baseTextStyle(
  color: kPrimary900Color,
  fontWeight: FontWeight.w600,
);

TextStyle kTitleTextStyle = baseTextStyle(
  color: Colors.black,
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
);

TextStyle kSubTitleTextStyle = baseTextStyle(
  color: Colors.black,
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
);

TextStyle kLabelTextStyle = baseTextStyle(
  color: Colors.black,
  fontSize: 11.0,
  fontWeight: FontWeight.w500,
);

TextStyle kRatingTextStyle = baseTextStyle(
  color: kWarning300Color,
  fontSize: 11.0,
);

TextStyle kGreyTextStyle = baseTextStyle(
  color: kGrey300Color,
);
