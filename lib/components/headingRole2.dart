import 'package:flutter/material.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

Widget headingRole2(BuildContext context, String title, {Function togNav, Color colorMain, bool canGoBack: false, bool solid: false, double fontSize: 18, String avatar}){
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
            backgroundImage:NetworkImage(avatar != null ? avatar : "https://cdn.pixabay.com/photo/2017/06/02/19/12/broken-link-2367103_960_720.png"),
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