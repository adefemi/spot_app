import 'package:flutter/material.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

Widget offerClaimCard(BuildContext context, {Widget date, String title = "", String image = "", Function onTap}){
  return Container(
      height: getSize(context, 100),
      margin: EdgeInsets.only(bottom: getSize(context, 20)),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getSize(context, 30)),
          color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: getSize(context, 60),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(getSize(context, 20)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(image),
                    )
                ),
              ),
              SizedBox(width: getSize(context, 20),),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    textControl(title, context, size: getSize(context, 15),fontWeight: FontWeight.w600, color: colors.blueColor.withOpacity(0.7)),
                    SizedBox(height: getSize(context, 5),),
                    date

                  ]
              )
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: insertContent(context, borderRadius: 10, color: Colors.black.withOpacity(0.2),
                child: insertContent(
                    context, width: 39, height: 39, borderRadius: 10, color: Colors.white,
                    child: Icon(Icons.chat_bubble, size: getSize(context, 16), color: colors.pinkColor,))),
          )
        ],
      )
  );
}