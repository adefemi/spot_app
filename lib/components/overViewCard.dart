import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

Widget overViewCard(BuildContext context, String count, String title, Color color, {bool isFirst: false, bool isLast: false, bool zero: false, Function onTap}){
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      children: <Widget>[
        Container(

          margin: EdgeInsets.only(
            left: zero ? 0 :isFirst ?  getWidth(context) / 10 : 0,
            right: zero ? 0 :isLast ? getWidth(context) / 10 : 15
          ),

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getSize(context, 40)),
              color: color
          ),
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: getSize(context, 20)),
                width: getSize(context, zero ? getWidth(context) : 160),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: textControl(count, context, size: getSize(context, 20), fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        width: getSize(context, zero ? 80 : 40),
                        height: getSize(context, zero ? 80 : 40),
                        decoration: BoxDecoration(
                          color: zero ? Colors.white.withOpacity(0.3) : Colors.transparent,
                          borderRadius: BorderRadius.circular(getSize(context, 20))
                        ),
                      ),
                      textControl(title, context, size: getSize(context, 17), fontWeight: FontWeight.w500, color: Colors.white)
                    ]
                ),
              ),
              Positioned(
                right: -getSize(context, 90),
                top: -getSize(context, 100),
                child: Transform.scale(scale: 0.4, child: threeDots(context),),
              )
            ],
          ),
        ),

      ],
    ),
  );
}

Widget newOfferButton(BuildContext context, {Function onTap}){
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      children: <Widget>[
        DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: [10,10],
          radius: Radius.circular(40),
          color: colors.pinkColor,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: getSize(context, 20)),
                width: getWidth(context),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: textControl("+", context, size: getSize(context, 20), fontWeight: FontWeight.bold, color: colors.pinkColor),
                        ),
                        width: getSize(context, 80),
                        height: getSize(context, 80),
                        decoration: BoxDecoration(
                            color: colors.pinkColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(getSize(context, 20))
                        ),
                      ),
                      textControl("New Offer", context, size: getSize(context, 17), fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.7))
                    ]
                ),
              ),
            ],
          ),
        ),

      ],
    ),
  );
}