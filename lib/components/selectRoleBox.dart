import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/fonts.dart';


Widget selectRoleBox(String imageAsset, String text, {double imageWidth: 40, bool first: true}){
  return Flexible(
    flex: 1,
    child: Container(
      margin: EdgeInsets.only(right: first ? 10 : 0, left: first ? 0 : 10),
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40)
      ),
      child: SizedBox.expand(
        child: Column(
          children: <Widget>[
            textControl(text, size: 16, color: Colors.black.withOpacity(0.5), font: fonts.proxima),
            SizedBox(height: 20,),
            Image.asset(imageAsset, width: imageWidth,)
          ],
        ),
      ),
    ),
  );
}