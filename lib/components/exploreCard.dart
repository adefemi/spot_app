import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/imageBanner.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

Widget exploreCard(BuildContext context, {bool showShadow: true, String image, String name, String price,
  String store: "Hassan Stores", String cat: "Sports", Function onPin, Function onChat, Function onView}){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
          Radius.circular(getSize(context, 30))
      ),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            offset: Offset(-5,10),
            blurRadius: 20,
            spreadRadius: 2,
            color: showShadow ? Colors.black.withOpacity(0.06) : Colors.transparent
        )
      ],
    ),
    child: Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: onView,
            child: Container(
              padding: EdgeInsets.all(getSize(context, 20)),
              decoration: BoxDecoration(
                color: colors.lightBlack,
                borderRadius: BorderRadius.all(
                    Radius.circular(getSize(context, 30))
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: insertContent(context, color: Colors.transparent, width: double.infinity, borderRadius: 0, height: double.infinity,
                        child: imageBanner(context, color: Colors.transparent, fitType: 1,
                            image: image,
                            width: double.infinity,
                            height: double.infinity
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: insertContent(context, width: 100, height:35, borderRadius: 35,
                        child: textControl(cat, context,color: Colors.white, size: 13, font: fonts.proxima, fontWeight: FontWeight.w500)),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        circle(10, color: colors.pinkColor),
                        SizedBox(width: getSize(context, 3),),
                        circle(6, color: colors.pinkColor.withOpacity(0.5)),
                        SizedBox(width: getSize(context, 3),),
                        circle(6, color: colors.pinkColor.withOpacity(0.5)),
                        SizedBox(width: getSize(context, 3),),
                        circle(6, color: colors.pinkColor.withOpacity(0.5)),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: getSize(context, 30), horizontal: getSize(context, 20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            textControl(name, context, color: colors.blueColor.withOpacity(0.9), size: 18,fontWeight: FontWeight.w600),
                            textControl(store, context, color: colors.blueColor.withOpacity(0.4), size: 13,fontWeight: FontWeight.w500, font: fonts.proxima),
                          ],
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: insertContent(context, borderRadius: 10, width: 50, height: 45, color: colors.blueColor3.withOpacity(0.3),
                              child: insertContent(
                                  context, width: 48, height: 43, borderRadius: 10, color: Colors.white,
                                  child: Icon(Icons.share, size: getSize(context, 18), color: colors.blueColor3,))),
                        )

                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    SizedBox(height: getSize(context, 30),),
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            textControl("PRICE", context, color: colors.deepPink.withOpacity(0.6), size: 11,fontWeight: FontWeight.bold, spacing: 5),
                            SizedBox(height: getSize(context, 7),),
                            textControl(price, context, color: colors.blueColor3.withOpacity(0.8), size: 18,fontWeight: FontWeight.bold),
                          ],
                        ),
//                        Row(
//                          children: <Widget>[
//                            insertContent(context,
//                                borderRadius: 10,
//                                height: 45,
//                                width: 45,
//                                color: colors.pinkColor.withOpacity(0.2),
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    textControl("45", context, size: 13, font: fonts.proxima, fontWeight: FontWeight.w500, color: colors.deepPink),
//                                    textControl("1/2", context, size: 7, font: fonts.proxima, fontWeight: FontWeight.w500, color: colors.deepPink)
//                                  ],
//                                )
//                            ),
//                            SizedBox(width: 10,),
//                            insertContent(context,
//                              borderRadius: 10,
//                              height: 45,
//                              width: 45,
//                              color: colors.pinkColor.withOpacity(0.2),
//                              child:textControl("XXL", context, size: 13, font: fonts.proxima, fontWeight: FontWeight.w500, color: colors.deepPink),
//                            ),
//                          ],
//                        )

                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ],
                ),
                Container(
                  height: getSize(context, 60),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: simpleButton("", context, onTap: (){
                          onPin(image);
                        }, child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              textControl("Pin", context, font: fonts.proxima, fontWeight: FontWeight.w500, size: 17, color: Colors.white),
                              SizedBox(width: getSize(context, 20),),
                              insertContent(context, color: Colors.black.withOpacity(0.3), borderRadius: 40, width: 50, child: SvgPicture.asset("assets/svgs/pin.svg", color: Colors.white,))
                            ])
                        ),
                      ),
                      SizedBox(width: getSize(context, 10),),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: simpleButton("", context, onTap: onChat, backColor: colors.pinkColor.withOpacity(0.2),
                          child: Icon(Icons.chat_bubble, color: colors.deepPink,), 
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}