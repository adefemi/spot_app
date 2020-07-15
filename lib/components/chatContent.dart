import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';


Widget chatContent(BuildContext context, {double radius: 15, bool owned: true, String message = "", String time: ""}){
  return Container(
    margin: EdgeInsets.only(top: getSize(context, 15)),
    child: Row(
      mainAxisAlignment: owned ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Column(
            crossAxisAlignment: owned ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: owned ? colors.pinkColor : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(getSize(context, owned ? radius : 0)),
                    bottomLeft: Radius.circular(getSize(context, radius)),
                    topRight: Radius.circular(getSize(context, radius)),
                    bottomRight: Radius.circular(getSize(context, owned ? 0 : radius)),
                  )
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(context, 25),
                  vertical: getSize(context, 20)
                ),
                child: Center(
                  child: textControl(message, context, size: 14, color: owned ? Colors.white : Colors.black.withOpacity(0.5)),
                ),
              ),
              SizedBox(height: getSize(context, 7),),
              textControl(time, context, size: 11, color: Colors.black.withOpacity(0.5), font: fonts.proxima)
            ],
          ),
        )
      ],
    ),
  );
}