import 'package:flutter/material.dart';
import 'package:spot_app/components/countrySelect.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';

Widget phoneInputField(){
  return Container(
    height: 82,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.01),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset.fromDirection(1, 10)
          )
        ]
    ),
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Center(
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          countryPicker(),
          SizedBox(width: 10,),
          Flexible(
              flex: 1,
              child:Container(
                width: double.infinity,
                child:
                textControl("803 791 3530",
                    size: 17,
                    fontWeight: FontWeight.w600),
              )
          ),
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
                color: colors.blueLight,
                borderRadius: BorderRadius.circular(40)
            ),
            child: Icon(Icons.check, size: 14, color: Colors.white,),
          )
        ],
      ),
    ),
  );
}

Widget otpInputField({double borderRadius: 15, double height: 82}){
  return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset.fromDirection(1, 10)
          )
        ]
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
  );
}

Widget inputSelectField(String placeholder, {double borderRadius: 15, double height: 82}){
  return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset.fromDirection(1, 10)
          )
        ]
      ),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          textControl(placeholder, size: 15, font: fonts.proxima, color: Colors.black.withOpacity(0.3)),
          Icon(Icons.arrow_drop_down, color: colors.pinkColor,)
        ],
      )
  );
}