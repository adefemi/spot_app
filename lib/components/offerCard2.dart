import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

Widget offerCard2(BuildContext context, String count, String title, Color color, Widget icon, {bool isFirst: false, bool isLast: false}){
  double width = getSize(context, getWidth(context) / 2.8);
  return Stack(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(
          left: isFirst ? getSize(context, getWidth(context) / 10) : 0,
          right: isLast ? getSize(context, getWidth(context) / 10) : 15
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getSize(context, 25)),
            color: Colors.white
        ),
        child: Container(
          width: width,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: getSize(context, 60),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(getSize(context, 20)),
                          color: color.withOpacity(0.15)
                      ),
                      child: Center(
                        child: textControl(count, context, color: color, size: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: getSize(context, 10),),
                    textControl(title, context, size: 14, fontWeight: FontWeight.w600, color: colors.blueColor.withOpacity(0.6))
                  ],
                ),
              ),
              Positioned(
                bottom: -getSize(context, 15),
                child: Container(
                  width: width,
                  child: Center(
                    child: icon,
                  ),
                ),
              )
            ],
          )
        ),
      ),

    ],
  );
}