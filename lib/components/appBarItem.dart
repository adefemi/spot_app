import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_app/utils/fonts.dart';


Widget appBarItem(String text, String icon, {bool active: false}){


  return Container(
    width: 50,
    decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
                width: 2,
                color: active ? colors.deepPink : Colors.transparent
            )
        )
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 20,
          height: 20,
          child: SvgPicture.asset("assets/svgs/$icon",
              color: active ?colors.deepPink :colors.blueColor.withOpacity(0.5)),
        ),
        SizedBox(height: 5,),
        textControl(text, size: 10, font: fonts.proxima,
            fontWeight: active ? FontWeight.w700 : FontWeight.w600,
            color: colors.blueColor.withOpacity(active ? 1 : 0.5))
      ],
    ),
  );
}