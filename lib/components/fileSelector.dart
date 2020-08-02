import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

Widget fileSelector(BuildContext context, {double height: 67, double borderRadius: 16, Widget child, Color color, Function onClick}){
  if(color == null){
    color = colors.blueColor2;
  }
  return GestureDetector(
    onTap: onClick,
    child: DottedBorder(
      borderType: BorderType.RRect,
      dashPattern: [10,10],
      radius: Radius.circular(getSize(context, borderRadius)),
      color: color,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(getSize(context, borderRadius))),
        child: Container(
          color: color.withOpacity(0.2),
          height: getSize(context, height),
          child: Center(
            child: child == null ? textControl("Browse Gallery", context,  size: 14, color: colors.fileSelectText,
                font: fonts.proxima, fontWeight: FontWeight.w500) : child,
          ),
        ),
      ),
    ),
  );
}