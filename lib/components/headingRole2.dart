import 'package:flutter/material.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';

Widget headingRole2(BuildContext context, String title, {Function togNav}){
  Color color = Colors.white;
  return  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(title, style: TextStyle(
          fontFamily: fonts.qanelas,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: color
      ),),
      Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage:NetworkImage("https://cdn.pixabay.com/photo/2016/08/28/13/12/secondlife-1625903_960_720.jpg"),
          ),
          SizedBox(width: 10,),
          GestureDetector(
            onTap: togNav,
            child: Icon(Icons.short_text, size: 30, color: Colors.white,),
          )
        ],
      )
    ],
  );
}