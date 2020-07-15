import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spot_app/utils/helpers.dart';

Widget simpleButton(
    String text,
    BuildContext context,
    {
      double padV: 60, double padH: 200,
      double fontSize: 17, double borderRadius: 30,
      Color backColor, Color color, FontWeight fontWeight,
      Function onTap,
      bool loading = false,
      Color loaderColor,
      Widget child
    }
    ){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: getSize(context, padV),
      width: getSize(context, padH),
      child: Center(
        child: loading ? SpinKitThreeBounce(
          size: getSize(context, 20),
          color: loaderColor == null ? Colors.white : loaderColor,
        ):
        child == null ? textControl(text, context, size: fontSize,
            color: color == null ? Colors.white : color,
            fontWeight: fontWeight == null ? FontWeight.w600 : fontWeight):child,
      ),
      decoration: BoxDecoration(
          color: backColor == null ? colors.blueColor : backColor,
          borderRadius: BorderRadius.circular(borderRadius)
      ),
    ),
  );
}