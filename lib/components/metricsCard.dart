import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/helpers.dart';

Widget metricsCard(BuildContext context, String count, String title, Color color, Widget icon, {bool isFirst: false, bool isLast: false}){
  return Stack(
    children: <Widget>[
      Container(

        margin: EdgeInsets.only(
          left: isFirst ? getSize(context, getWidth(context) / 10) : 0,
          right: isLast ? getSize(context, getWidth(context) / 10) : 15
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getSize(context, 30)),
            color: Colors.white
        ),
        child: Container(
          padding: EdgeInsets.all(getSize(context, 20)),
          width: getSize(context, 190),
          child: Row(
            
            children: <Widget>[
              Container(
                width: getSize(context, 50),
                height: getSize(context, 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(getSize(context, 15)),
                      color: color
                  ),
                child: Center(
                  child: icon,
                ),
              ),
              SizedBox(width: getSize(context, 15),),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    textControl(count, context, size: getSize(context, 16), fontWeight: FontWeight.w600),
                    textControl(title, context, size: getSize(context, 13), color: Colors.black.withOpacity(0.4))
                  ]
              )
            ],
          ),
        ),
      ),

    ],
  );
}