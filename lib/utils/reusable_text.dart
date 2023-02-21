import 'package:flutter/cupertino.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:google_fonts/google_fonts.dart';

Widget normalText({text, Color color = white}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: Dimensions.fontSize16,
        fontWeight: FontWeight.w500,
        color: color),
  );
}

Widget headingText({text, Color color = nicePurple, fontSize = 20.0}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: fontSize, fontWeight: FontWeight.w800, color: color),
  );
}

Text appNameText(
    {text, FontWeight? fontWeight, Color? color, size, letterSpacing}) {
  return Text(
    text,
    style: GoogleFonts.lobster(
        letterSpacing: letterSpacing ?? 3.0,
        fontSize: size,
        fontWeight: fontWeight ?? FontWeight.w200,
        color: color ?? mainAppColor),
  );
}
