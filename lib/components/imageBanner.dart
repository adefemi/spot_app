import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

Widget imageBanner(BuildContext context, {double height: 40,double width: 40, Color color, String image, Function onTap, double borderRadius: 6, int fitType: 0}){
  if(color == null){
    color = Colors.black.withOpacity(0.2);
  }

  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: getSize(context, height),
      width: getSize(context, width),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(getSize(context, borderRadius)),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: fitType == 0 ? BoxFit.cover : BoxFit.contain
        )
      ),
    ),
  );
}