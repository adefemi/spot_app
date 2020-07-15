import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/imageBanner.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/offerCard.dart';
import 'package:spot_app/components/offerClaimCard.dart';
import 'package:spot_app/components/offerTab.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

class ProductView extends StatefulWidget {
  const ProductView(this.showSideBar);
  final Function showSideBar;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        backgroundColor: colors.blueColor2.withOpacity(0.05),
        appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context)/20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.chevron_left, size: getSize(context, 30), color: colors.blueColor3,),
                ),
                Row(
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
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.zoom_out_map, size: getSize(context, 30), color: colors.blueColor3.withOpacity(0.7),),
                ),
              ],
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0.03),
        ),
        body: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              Container(
                height: getHeight(context)/2,
                child: PageView(
                  children: <Widget>[
                    insertContent(context, color: Colors.black.withOpacity(0.03), width: getWidth(context), borderRadius: 0, height: getHeight(context)/2,
                      child: imageBanner(context, color: Colors.transparent,
                          image: "https://cdn.pixabay.com/photo/2017/08/07/23/28/still-2609141_960_720.jpg",
                          width: getWidth(context)/1.1,
                          height: getHeight(context)/2.2
                      ),
                    ),
                    insertContent(context, color: Colors.black.withOpacity(0.03), width: getWidth(context), borderRadius: 0, height: getHeight(context)/2,
                      child: imageBanner(context, color: Colors.transparent,
                          image: "https://cdn.pixabay.com/photo/2014/04/05/11/38/nike-316449__340.jpg",
                          width: getWidth(context)/1.1,
                          height: getHeight(context)/2.2
                      ),
                    ),
                    insertContent(context, color: Colors.black.withOpacity(0.03), width: getWidth(context), borderRadius: 0, height: getHeight(context)/2,
                      child: imageBanner(context, color: Colors.transparent,
                          image: "https://cdn.pixabay.com/photo/2018/09/30/21/28/sneakers-3714729__340.jpg",
                          width: getWidth(context)/1.1,
                          height: getHeight(context)/2.2
                      ),
                    ),
                    insertContent(context, color: Colors.black.withOpacity(0.03), width: getWidth(context), borderRadius: 0, height: getHeight(context)/2,
                      child: imageBanner(context, color: Colors.transparent,
                          image: "https://cdn.pixabay.com/photo/2018/09/30/21/29/sneakers-3714730__340.jpg",
                          width: getWidth(context)/1.1,
                          height: getHeight(context)/2.2
                      ),
                    ),
                  ],
                ),
              ),

              SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      IgnorePointer(
                        child: SizedBox(height: getHeight(context)/1.9,),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(getSize(context, 50))),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.03),
                                  spreadRadius: 2
                              )
                            ]
                        ),
                        padding: EdgeInsets.symmetric(vertical: getSize(context, 30), horizontal: getWidth(context)/10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: getSize(context, 100),
                                  child: offerTab(context, text: "Pending",defaultTextColor: Colors.white, defaultColor: colors.blueColor3),
                                ),
                                textControl("Listed 21 Mar", context, color: Colors.black.withOpacity(0.3), size: 13, font: fonts.proxima),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            SizedBox(height: getSize(context, 20),),
                            pinnedContent(context),
                            SizedBox(height: getHeight(context)/5,),
                          ],
                        ),
                      )
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }
}

Widget unPinnedContent(BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          textControl("Nike Air Max", context, color: colors.blueColor.withOpacity(0.9), size: 18,fontWeight: FontWeight.w600),
          Container(
            width: getSize(context, 90),
            child: offerTab(context, text: "Edit",defaultTextColor: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w600, defaultColor: colors.blueColor3.withOpacity(0.2),
                onTap: () => Navigator.of(context).pushNamed("/newOffer")
            ),
          ),

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
              textControl("N10,000", context, color: colors.blueColor3.withOpacity(0.8), size: 18,fontWeight: FontWeight.bold),
            ],
          ),
          Row(
            children: <Widget>[
              insertContent(context,
                  borderRadius: 10,
                  height: 45,
                  width: 45,
                  color: colors.pinkColor.withOpacity(0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      textControl("45", context, size: 13, font: fonts.proxima, fontWeight: FontWeight.w500, color: colors.deepPink),
                      textControl("1/2", context, size: 7, font: fonts.proxima, fontWeight: FontWeight.w500, color: colors.deepPink)
                    ],
                  )
              ),
              SizedBox(width: 10,),
              insertContent(context,
                borderRadius: 10,
                height: 45,
                width: 45,
                color: colors.pinkColor.withOpacity(0.2),
                child:textControl("XXL", context, size: 13, font: fonts.proxima, fontWeight: FontWeight.w500, color: colors.deepPink),
              ),
            ],
          )

        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      SizedBox(height: getSize(context, 30),),
      textControl("Description", context, color: colors.blueColor.withOpacity(0.7), size: 15,fontWeight: FontWeight.w600, font: fonts.proxima),
      SizedBox(height: getSize(context, 20),),
      textControl("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sodales ex nec eros tempor tristique. Aliquam a congue quam. "
          "Pellentesque vulputate ligula dictum lectus tincidunt, vel pharetra odio auctor. Donec", context, height: 2,
          color: Colors.black.withOpacity(0.5), size: 13, font: fonts.proxima),
    ],
  );
}

Widget pinnedContent(BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      textControl("Pink Nike Air Max", context, color: colors.blueColor.withOpacity(0.9), size: 18,fontWeight: FontWeight.w600),
      SizedBox(height: getSize(context, 5),),
      insertContent(context,
          width: 150,
          borderRadius: 40,
          color: Colors.black.withOpacity(0.05),
          child: textControl("Go to Offer Card",  context, color: Colors.black.withOpacity(0.7), size: 13,fontWeight: FontWeight.w600)),
      SizedBox(height: getSize(context, 20),),
      textControl("00:20:00", context, color: colors.pinkColor, size: 25,fontWeight: FontWeight.bold),
      SizedBox(height: getSize(context, 10),),
      textControl("TIMER", context, color: colors.pinkColor, size: 11,fontWeight: FontWeight.bold, spacing: 5),
      SizedBox(height: getSize(context, 20),),
      simpleButton("Open Barcode", context, padH: double.infinity, onTap: (){
        Navigator.of(context).pushNamed("/barcode");
      },
          color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w500, padV: 70, borderRadius: 70)

    ],
  );
}