import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

Widget chatCard(BuildContext context, String name, String image, {double radius: 60, String message: "", String time: "9.36 am", String count: "", Function onTap, bool type2: false, Widget extra}) {
  return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.only(bottom: getSize(context, type2 ? 0 : 30)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: getSize(context, radius),
                      width: getSize(context, radius),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                              getSize(context, radius)),
                          image: DecorationImage(
                              image: NetworkImage(image), fit: BoxFit.cover)
                      ),
                    ),
                    SizedBox(width: getSize(context, 20),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        textControl(name, context, size: 15,
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w600),
                        message == "" ? SizedBox() : SizedBox(height: getSize(context, 8)),
                        message == "" ? SizedBox() : Row(
                          children: <Widget>[
                            textControl(message, context, size: 13,
                                color: Colors.black.withOpacity(0.4),
                                fontWeight: FontWeight.w600),
                            extra != null ? extra : SizedBox()
                          ],
                        )
                      ],
                    )
                  ],
                ),
                type2 ? SizedBox() : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      textControl(time, context, size: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.3)),
                      SizedBox(height: getSize(context, 5),),
                      count == "0" || count == "" ? SizedBox() :
                      Container(
                        height: getSize(context, 25),
                        width: getSize(context, 60),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                getSize(context, 20)),
                            color: colors.deepPink
                        ),
                        child: Center(
                          child: textControl(
                              "+ $count", context, color: Colors.white,
                              size: 11,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ]
                )
              ]
          )
      )
  );
}
 