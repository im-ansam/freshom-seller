import 'package:flutter/cupertino.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/utils/reusable_big_text.dart';
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

RichText appNameText(
    {size,
    FontWeight? fontWeight1,
    FontWeight? fontWeight2,
    Color? color,
    letterSpacing1,
    letterSpacing2}) {
  return RichText(
    text: TextSpan(
        text: "Fresh",
        style: GoogleFonts.poppins(
          letterSpacing: letterSpacing1 ?? 1.0,
          fontSize: size,
          fontWeight: fontWeight1,
          color: color ?? mainAppColor,
        ),
        children: [
          TextSpan(
              text: "'Om",
              style: GoogleFonts.poppins(
                  letterSpacing: letterSpacing2 ?? 1.0,
                  fontWeight: fontWeight2,
                  fontSize: size,
                  color: color ?? mainAppColor))
        ]),
  );

  //   Text(
  //   text,
  //   style: GoogleFonts.poppins(
  //       letterSpacing: letterSpacing ?? 1.0,
  //       fontSize: size,
  //       fontWeight: fontWeight ?? FontWeight.w200,
  //       color: color ?? mainAppColor),
  // );
}
