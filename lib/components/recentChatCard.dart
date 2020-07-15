import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/helpers.dart';

Widget recentChatCard(BuildContext context, String name, String image, {bool isFirst: false, bool isLast: false, double radius: 60, Function onTap}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(left: isFirst ? getWidth(context)/10 : getSize(context, 30), right: isLast ? getWidth(context)/10: 0),
      child: Column(
        children: <Widget>[
          Container(
            height: getSize(context, radius),
            width: getSize(context, radius),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(getSize(context, radius)),
                image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)
            ),
          )    ,
          SizedBox(height: getSize(context, 7),),
          textControl(name, context, size: 11, color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.w600)
        ],
      ),
    ),
  );
}