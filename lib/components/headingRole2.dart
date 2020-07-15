import 'package:flutter/material.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

Widget headingRole2(BuildContext context, String title, {Function togNav, Color colorMain, bool canGoBack: false, bool solid: false, double fontSize: 18}){
  Color color = Colors.white;
  if(colorMain != null){
    color = colorMain;
  }
  return  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
        children: <Widget>[
          canGoBack ? GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.chevron_left, size: getSize(context, 30), color: color,),
          ) : SizedBox(),
          Text(canGoBack ? "  $title": title, style: TextStyle(
              fontFamily: fonts.qanelas,
              fontWeight: FontWeight.w500,
              fontSize: getSize(context, fontSize),
              color: solid ? color : color.withOpacity(0.5)
          ),),
        ],
      ),
      togNav == null ? SizedBox() :
      Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage:NetworkImage("https://cdn.pixabay.com/photo/2016/08/28/13/12/secondlife-1625903_960_720.jpg"),
          ),
          SizedBox(width: getSize(context, 10),),
          GestureDetector(
            onTap: togNav,
            child: Icon(Icons.short_text, size: getSize(context, 30), color: color,),
          )
        ],
      )
    ],
  );
}