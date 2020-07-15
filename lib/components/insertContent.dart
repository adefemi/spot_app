import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

Widget insertContent(BuildContext context, {double height: 40,double width: 40, Color color, Widget child, Function onTap, double borderRadius: 6}){
  if(color == null){
    color = colors.pinkColor;
  }

  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: getSize(context, height),
      width: getSize(context, width),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(getSize(context, borderRadius))
      ),
      child: Center(
        child: child
      ),
    ),
  );
}