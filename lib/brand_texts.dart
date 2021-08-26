import 'package:flutter/material.dart';

import 'brand_colors.dart';

class BrandTexts {
  // brand font
  static String brandFont = "NotoSansJP";
  // static String logoFont = "OriginalSurfer";
  // static String tamilFont = "Bamini";

  // font weights
  // static FontWeight thin = FontWeight.w100;
  // static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight bold = FontWeight.w700;
  // static FontWeight black = FontWeight.w900;

  //header
  // sub title bold
  static Text header({
    @required String text,
    int maxLines = 1,
    TextOverflow overflow = TextOverflow.ellipsis,
    FontWeight fontWeight,
    TextAlign textAlign,
    Color color,
    double fontSize = 20.0,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.start,
      style: textStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight ?? regular,
      ),
    );
  }

  // title
  static Text title({
    @required String text,
    int maxLines = 1,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextAlign textAlign,
    Color color,
    double height,
    double fontSize = 16.0,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.start,
      style: textStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: regular,
        height: height,
      ),
    );
  }

  // title bold
  static Text titleBold({
    @required String text,
    int maxLines = 1,
    TextOverflow overflow = TextOverflow.ellipsis,
    FontWeight fontWeight,
    TextAlign textAlign,
    Color color,
    double fontSize = 16.0,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.start,
      style: textStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: bold,
      ),
    );
  }

  // sub title
  static Text subTitle({
    @required String text,
    int maxLines = 1,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextAlign textAlign,
    Color color,
    double height,
    double fontSize = 14.0,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.start,
      style: textStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: regular,
        height: height,
      ),
    );
  }

  // sub title bold
  static Text subTitleBold({
    @required String text,
    int maxLines = 1,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextAlign textAlign,
    Color color,
    double fontSize = 14.0,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.start,
      style: textStyle(color: color, fontSize: fontSize, fontWeight: bold, fontStyle: fontStyle),
    );
  }

  // caption
  static Text caption({
    @required String text,
    int maxLines = 1,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextAlign textAlign,
    FontWeight fontWeight,
    Color color,
    double fontSize = 12.0,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.start,
      style: textStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight ?? regular,
      ),
    );
  }

  // common text
  static Text commonText({
    @required String text,
    int maxLines = 1,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextAlign textAlign,
    FontWeight fontWeight,
    Color color,
    double fontSize = 18.0,
    double letterSpacing = 0.2,
    FontStyle fontStyle = FontStyle.normal,
    String fontFamily,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.start,
      style: textStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight ?? regular,
        letterSpacing: letterSpacing,
        fontStyle: fontStyle,
        fontFamily: fontFamily,
      ),
    );
  }

  // text common style
  static TextStyle textStyle({
    double fontSize = 16.0,
    FontWeight fontWeight,
    Color color,
    bool isCrossText = false,
    double letterSpacing = 0.2,
    double height,
    FontStyle fontStyle = FontStyle.normal,
    String fontFamily,
  }) =>
      TextStyle(
          fontFamily: fontFamily ?? brandFont,
          fontStyle: fontStyle,
          fontSize: fontSize,
          fontWeight: fontWeight ?? regular,
          letterSpacing: letterSpacing,
          color: color ?? BrandColors.dark,
          height: height,
          decoration: isCrossText ? TextDecoration.lineThrough : TextDecoration.none);
}
