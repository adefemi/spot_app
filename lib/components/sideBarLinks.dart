import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/helpers.dart';

Widget sideBarLinks(BuildContext context, {String title: "", String icon: "", Function onTap}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(bottom: getHeight(context)/ 17),
      child: Row(
        children: <Widget>[
          SvgPicture.asset("assets/svgs/$icon", color: Colors.white,),
          SizedBox(width: getSize(context, 20),),
          textControl(title, context, size: getSize(context, 16), fontWeight: FontWeight.w500, color: Colors.white)
        ],
      ),
    ),
  );
}