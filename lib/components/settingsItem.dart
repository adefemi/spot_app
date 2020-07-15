import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

Widget settingListContent(BuildContext context, String icon, String title, {bool canToggle: false, bool last: false, Function onTap}){
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: getSize(context, 50), width: getSize(context, 50),
                  child: Center(
                    child: SvgPicture.asset(icon, color: colors.deepPink,),
                  ),
                ),
                SizedBox(width: getSize(context, 20),),
                textControl(title, context, size: 16, color: Colors.black.withOpacity(0.6), font: fonts.proxima),

              ],
            ),
            canToggle ? Switch(onChanged: (status){}, value: true,) : SizedBox()
          ],
        ),
        SizedBox(height: getSize(context, 20),),
        !last ? Container(
          padding: EdgeInsets.symmetric(horizontal: getSize(context, 20)),
          height: 1,
          color: Colors.black.withOpacity(0.1),
        ) : SizedBox(),
        SizedBox(height: getSize(context, 20),)
      ],
    ),
  );
}