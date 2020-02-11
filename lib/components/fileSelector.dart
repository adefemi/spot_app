import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';

Widget fileSelector(BuildContext context){
  return DottedBorder(
    borderType: BorderType.RRect,
    dashPattern: [10,10],
    radius: Radius.circular(16),
    color: colors.blueColor2,
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      child: Container(
        color: colors.blueColor2.withOpacity(0.2),
        height: 67,
        child: Center(
          child: textControl("Browse Gallery", size: 14, color: colors.fileSelectText,
              font: fonts.proxima, fontWeight: FontWeight.w500),
        ),
      ),
    ),
  );
}