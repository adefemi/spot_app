import 'package:flutter/material.dart';
import 'package:spot_app/utils/helpers.dart';

Widget threeDots(BuildContext context, {Color color}){
  if (color == null){
    color = Colors.white.withOpacity(0.12);
  }
  return Container(
    width: getSize(context, 250),
    height: getSize(context, 250),
    child: Stack(
      children: <Widget>[
        Positioned(
          child: circle(getSize(context, 90), color: color),
          left: getSize(context, 100),
          top: getSize(context, 120),
        ),
        Positioned(
          child: circle(getSize(context, 35), color: color),
          left: getSize(context, 120),
          top: getSize(context, 60),
        ),
        Positioned(
          child: circle(getSize(context, 60), color: color),
          left: getSize(context, 30),
          top: getSize(context, 30),
        ),
        Positioned(
          child: circle(getSize(context, 70), color: color),
          right: getSize(context, 20),
          top: getSize(context, 0),
        ),
      ],
    ),
  );
}

Widget circle(double radius, {Color color}){
  if (color == null){
    color = Colors.white.withOpacity(0.12);
  }
  return Container(
    width: radius,
    height: radius,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color,
    ),
  );
}