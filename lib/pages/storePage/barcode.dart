import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/imageBanner.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

class Barcode extends StatefulWidget {
  @override
  _BarcodeState createState() => _BarcodeState();
}

class _BarcodeState extends State<Barcode> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        bgColorLayer(),
        Positioned(
          bottom: -getHeight(context)/5,
          right: getSize(context, 30),
          child: Transform.rotate(
            angle: (-70 * 3.142/180),
            child: Transform.scale(scale: 1.8, child: threeDots(context, color: Colors.white.withOpacity(0.6)),),
          ),
        ),
        Scaffold(
          backgroundColor: colors.deepPink.withOpacity(0.6),
          appBar: AppBar(
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context)/15),
              child: headingRole2(context, "Barcode", fontSize: 15, colorMain:Colors.white, canGoBack: true, solid: true),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Stack(
            children: <Widget>[
              Positioned(
                left: getWidth(context)/10,
                bottom: getSize(context, 20),
                child: FloatingActionButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  backgroundColor: Colors.white,
                  child: Icon(Icons.chevron_left, color: colors.pinkColor,),
                  elevation: 2,
                ),
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      insertContent(context, width: getWidth(context)/1.2, borderRadius: getSize(context, 50), 
                          child: Stack(
                            children: <Widget>[

                              Center(
                                child: Transform.scale(
                                  child: Image.asset("assets/pngs/corner.png",),
                                  scale: 1.2,
                                ),
                              ),

                              Center(
                                child: imageBanner(context,
                                    color: Colors.transparent,
                                    width: getWidth(context)/1.6,
                                    height: getHeight(context)/2.4,
                                    image: "https://pngimg.com/uploads/qr_code/qr_code_PNG6.png"),
                              )
                            ],
                          ),
                          height: getHeight(context)/1.8, color: Colors.white),
                      SizedBox(height: getSize(context, 30),),
                      textControl("Show Code to Merchant to", context, color: Colors.white.withOpacity(0.8), size: 15, font: fonts.proxima),
                      textControl("redeem offer", context, color: Colors.white.withOpacity(0.8), size: 15, font: fonts.proxima),
                      SizedBox(height: getSize(context, 50),),
                    ],
                  ),
                )
              )
            ],
          ),
        )
      ],
    );
  }
}
