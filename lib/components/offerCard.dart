import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/helpers.dart';

Widget offerCard(BuildContext context, {String date = "", String title = "", String image = "", Function onTap}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: getSize(context, 120),
        margin: EdgeInsets.only(bottom: getSize(context, 20)),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getSize(context, 30)),
            color: Colors.white
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: getSize(context, 100),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(getSize(context, 20)),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(image),
                )
              ),
            ),
            SizedBox(width: getSize(context, 20),),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  textControl(title, context, size: getSize(context, 15),fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.6)),
                  date == "" ? SizedBox() :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: getSize(context, 5),),
                      textControl(date, context, size: getSize(context, 11), fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.3)),
                    ],
                  )
                ]
            )
          ],
        )
    ),
  );
}