import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';

Widget simpleButton(
    String text,
    {
      double padV: 20, double padH: 50,
      double fontSize: 17, double borderRadius: 30,
      Color backColor, Color color, FontWeight fontWeight
    }
    ){
  return Container(
    padding: EdgeInsets.symmetric(vertical: padV, horizontal: padH),
    child: textControl(text, size: fontSize,
        color: color == null ? Colors.white : color,
        fontWeight: fontWeight == null ? FontWeight.w600 : fontWeight),
    decoration: BoxDecoration(
        color: backColor == null ? colors.blueColor : backColor,
        borderRadius: BorderRadius.circular(borderRadius)
    ),
  );
}