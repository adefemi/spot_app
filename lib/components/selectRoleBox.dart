import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';


Widget selectRoleBox(String imageAsset, String text, {double imageWidth: 40, bool first: true, double paddingTop: 30, bool active: false, Function onTap, double scaleFactor = 1}){
  return Flexible(
    flex: 1,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: first ? 10 : 0, left: first ? 0 : 10),
        padding: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: active ? colors.pinkColor : Colors.white,
            borderRadius: BorderRadius.circular(40)
        ),
        child: SizedBox.expand(
          child: Column(
            children: <Widget>[
              textControl(
                  text, size: 16,
                  color: active ? Colors.white : Colors.black.withOpacity(0.5),
                  font: fonts.proxima),
              SizedBox(height: paddingTop,),
              Transform.scale(scale: scaleFactor, child: SvgPicture.asset(imageAsset, width: imageWidth, color: active ? Colors.white : colors.pinkColor,),)
            ],
          ),
        ),
      ),
    ),
  );
}