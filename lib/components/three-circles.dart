import 'package:flutter/material.dart';

Widget threeDots(BuildContext context, {Color color}){
  if (color == null){
    color = Colors.white.withOpacity(0.12);
  }
  return Container(
    width: 250,
    height: 250,
    child: Stack(
      children: <Widget>[
        Positioned(
          child: circle(90, color: color),
          left: 100,
          top: 120,
        ),
        Positioned(
          child: circle(35, color: color),
          left: 120,
          top: 60,
        ),
        Positioned(
          child: circle(60, color: color),
          left: 30,
          top: 30,
        ),
        Positioned(
          child: circle(70, color: color),
          right: 20,
          top: 0,
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
      borderRadius: BorderRadius.circular(50),
      color: color,
    ),
  );
}