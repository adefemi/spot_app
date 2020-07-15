import 'package:flutter/material.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

Widget progressStep(BuildContext context, {double height: 2, bool active: false, Color activeColor, Color defaultColor, double width, bool isLast: false}){
  if(activeColor == null){
    activeColor = colors.pinkColor;
  }
  if(defaultColor == null){
    defaultColor = colors.whiteBlue;
  }
  if(width == null){
    width = getWidth(context) / 7.5;
  }
  return Container(
    height: getSize(context, active ? height * 2 : height),
    width: active ? width + 20 : width,
    margin: EdgeInsets.only(right: isLast ? 0 : 5),
    decoration: BoxDecoration(
      color: active ? activeColor : defaultColor,
      borderRadius: BorderRadius.circular(getSize(context, height))
    ),
  );
}