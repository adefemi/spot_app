import 'package:flutter/material.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

Widget paymentCard(BuildContext context, {bool isFirst: false, String cardNum:"", String cardType:""}){
  return Container(
    height: getSize(context, 290),
    child: Column(
      children: <Widget>[
        Container(
          height: getSize(context, isFirst ? 240 : 220),
          width: isFirst ? getWidth(context) / 2.5 : getWidth(context) / 2.8,
          margin: EdgeInsets.only(right: getSize(context, 20), left: isFirst ? getWidth(context)/12 : 0, top: !isFirst ? getSize(context, 10):0),
          decoration: BoxDecoration(
              color: isFirst ? colors.blueColor : Colors.grey.shade400,
              borderRadius: BorderRadius.circular(getSize(context, 27))
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                right: getWidth(context) / 12,
                top: -getHeight(context) / 80,
                child: circle(getSize(context, 25), color: Colors.white.withOpacity(0.1)),
              ),
              Positioned(
                right: isFirst ? getWidth(context) / 5 : getWidth(context) / 7,
                top:  isFirst ? getHeight(context) / 3.5 : getHeight(context) / 4,
                child: circle(getSize(context, 30), color: Colors.white.withOpacity(0.13)),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: getSize(context, 30),
                    left: getSize(context, 30),
                    top: getSize(context, isFirst ? 30 : 20),
                    bottom: getSize(context, isFirst ? 60 : 50)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    textControl(cardNum, context, size: isFirst ? 16 : 14, color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w600),
                    textControl(cardType, context, size: isFirst ? 16 : 14, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w600)
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: getSize(context, 15),),
        isFirst ? insertContent(context, child: Icon(Icons.check, color: Colors.white, size: getSize(context, 15),),
            height: 30, width: 30, borderRadius: 30, color: colors.blueColor) : SizedBox()
      ],
    ),
  );
}