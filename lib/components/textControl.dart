import 'package:flutter/material.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';

Text textControl(String text, {
  FontWeight fontWeight: FontWeight.w400, String font,
  Key key, double size: 22, Color color, bool underline: false}
  ){
  if(color == null){
    color = colors.blueColor;
  }

  if(font == null){
    font = fonts.qanelas;
  }
  return Text(text,
      style: TextStyle(
          fontSize: size,
          fontFamily: font,
          fontWeight: fontWeight,
          color: color,
        decoration: underline ? TextDecoration.underline : null
      ),
    key: key,
  );
}