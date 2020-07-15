import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

Widget offerTab(BuildContext context, {double height: 40, bool active: false, Color activeColor, Color defaultColor, String text,
  Color defaultTextColor, Color activeTextColor, Function onTap, FontWeight fontWeight}){
  if(activeColor == null){
    activeColor = colors.pinkColor;
  }
  if(defaultColor == null){
    defaultColor = Colors.white;
  }
  if(activeTextColor == null){
    activeTextColor = Colors.white;
  }
  if(defaultTextColor == null){
    defaultTextColor = colors.blueColor3;
  }

  if(fontWeight == null){
    fontWeight = FontWeight.w400;
  }

  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: getSize(context, height),
      decoration: BoxDecoration(
        color: active ? activeColor : defaultColor,
        borderRadius: BorderRadius.circular(getSize(context, height))
      ),
      child: Center(
        child: textControl(text, context, color: active ? activeTextColor : defaultTextColor, size: 13, font: fonts.proxima, fontWeight: fontWeight),
      ),
    ),
  );
}