import 'package:flutter/material.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

Text textControl(String text, BuildContext context, {
  FontWeight fontWeight: FontWeight.w400, String font, double height: 1.5,
  Key key, double size: 22, Color color, bool underline: false, double spacing:0}
  ){
  if(color == null){
    color = colors.blueColor;
  }

  if(font == null){
    font = fonts.qanelas;
  }
  return Text(text,
      style: TextStyle(
          fontSize: getSize(context, size),
          fontFamily: font,
          fontWeight: fontWeight,
          color: color,
        letterSpacing: spacing,
        height: height,
        decoration: underline ? TextDecoration.underline : null
      ),
    key: key,
  );
}