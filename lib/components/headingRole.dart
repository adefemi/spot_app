import 'package:flutter/material.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';

Widget headingRole(BuildContext context, {bool isSideBar: false, Function goBack, bool canGoBack: false}){
  Color color = colors.blueColor;
  if(isSideBar){
    color = Colors.white;
  }
  return  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text("Spot", style: TextStyle(
          fontFamily: fonts.playFairItalic,
          fontSize: 22,
          color: color
      ),),
      !isSideBar ?
      GestureDetector(
        onTap: (){
          if(canGoBack){
            Navigator.of(context).pop();
          }
        },
        child: Text(canGoBack ? "Back":"", style: TextStyle(
            fontFamily: fonts.proxima,
            fontSize: 14,
            color: color
        ),),
      ): GestureDetector(
        onTap: goBack,
        child: Icon(Icons.close, color: Colors.white, size: 16,),
      )
    ],
  );
}