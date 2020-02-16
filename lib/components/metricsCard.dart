import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';

Widget metricsCard(BuildContext context, String count, String title, Color color, Widget icon, {bool isFirst: false, bool isLast: false}){
  return Stack(
    children: <Widget>[
      Container(

        margin: EdgeInsets.only(
          left: isFirst ?  MediaQuery.of(context).size.width / 10 : 0,
          right: isLast ? MediaQuery.of(context).size.width / 10 : 15
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width / 2.5,
          child: Row(
            
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: color
                  ),
                child: Center(
                  child: icon,
                ),
              ),
              SizedBox(width: 15,),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    textControl(count, size: 16, fontWeight: FontWeight.w600),
                    textControl(title, size: 13, color: Colors.black.withOpacity(0.4))
                  ]
              )
            ],
          ),
        ),
      ),

    ],
  );
}