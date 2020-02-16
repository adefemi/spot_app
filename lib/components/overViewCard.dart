import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';

Widget overViewCard(BuildContext context, String count, String title, Color color, {bool isFirst: false, bool isLast: false}){
  return Stack(
    children: <Widget>[
      Container(

        margin: EdgeInsets.only(
          left: isFirst ?  MediaQuery.of(context).size.width / 10 : 0,
          right: isLast ? MediaQuery.of(context).size.width / 10 : 15
        ),

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: color
        ),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 25),
              width: MediaQuery.of(context).size.width / 2.5,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    textControl(count, size: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    textControl(title, size: 17, fontWeight: FontWeight.w500, color: Colors.white)
                  ]
              ),
            ),
            Positioned(
              right: -MediaQuery.of(context).size.width / 5,
              top: -MediaQuery.of(context).size.height / 8,
              child: Transform.scale(scale: 0.4, child: threeDots(context),),
            )
          ],
        ),
      ),

    ],
  );
}