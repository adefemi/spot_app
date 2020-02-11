import 'package:flutter/material.dart';
import 'package:spot_app/utils/colors.dart';

Widget splashControl(onTap, {bool active: false}){
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: active ? 15 : 11,
      height: active ? 15 : 11,
      margin: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
          color:colors.deepPink.withOpacity(active ? 1 : 0.33),
          borderRadius: BorderRadius.circular(active ? 15 : 11)
      ),
    ),
  );
}