import 'package:flutter/material.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';

Text splashText(Map<String, String> controlArray, {bool head: true, Key key}){
  return Text(controlArray[head ? "head": "content"],
      style: TextStyle(
          fontSize: 22,
          fontFamily: fonts.qanelas,
          fontWeight: head ? FontWeight.w400: FontWeight.w700,
          color: colors.blueColor
      ),
    key: key,
  );
}