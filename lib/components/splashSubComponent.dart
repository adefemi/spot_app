import 'package:flutter/material.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

Widget splashSubComponent(BuildContext context,
    {bool first = false, bool last = false}){

  EdgeInsets margin = EdgeInsets.symmetric(
      vertical: getSize(context, 10),
      horizontal: (getWidth(context) -
          getWidth(context) / 1.4) /6);

  if(first){
    margin = EdgeInsets.only(
      top: 10, bottom: 10,
      left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width / 1.4) / 2,
      right: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width / 1.4) / 6
    );
  }

  if(last){
    margin = EdgeInsets.only(
      top: 10, bottom: 10,
      right: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width / 1.4) / 2,
      left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width / 1.4) / 6
    );
  }

  return Container(
    width: MediaQuery.of(context).size.width / 1.4,
    margin: margin,
    decoration: BoxDecoration(
        color: colors.lighterBlur,
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              spreadRadius: 2
          )
        ]
    ),
  );
}