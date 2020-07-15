import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

Widget formGroup(BuildContext context, Widget child, {String label="", double marginBottom: 20}){
  return Container(
    margin: EdgeInsets.only(bottom: getSize(context, marginBottom)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        label == "" ? SizedBox() :
        textControl(label, context, size: 15, color: colors.blueColor.withOpacity(0.6)),
        SizedBox(height: label == "" ? 0 : getSize(context, 10),),
        child
      ],
    ),
  );
}