import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/helpers.dart';

Widget mallCard(BuildContext context, String count, String title, String created){
  return Stack(
    children: <Widget>[
      Container(
        width: getWidth(context),
        height: getSize(context, 200),
        margin: EdgeInsets.only(bottom: getSize(context, 20)),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://cdn.pixabay.com/photo/2020/06/21/04/25/nyc-5323170__340.jpg"),
            fit: BoxFit.cover
          ),
            borderRadius: BorderRadius.circular(getSize(context, 20)),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getSize(context, 20)),
              color: Colors.black.withOpacity(0.5)
          ),
          child: Container(
            padding: EdgeInsets.all(getSize(context, 20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                textControl(title, context, color: Colors.white, size: 24, fontWeight: FontWeight.w600),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    textControl("Store Available: $count", context, color: Colors.white, size: 16),
                    textControl("Created: $created", context, color: Colors.white, size: 16)
                  ],
                )
              ],
            ),
          ),
        ),
      ),

    ],
  );
}