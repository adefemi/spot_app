import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spot_app/components/alertViewer.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/offerCard.dart';
import 'package:spot_app/components/paymentCard.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class PaymentMain extends StatefulWidget {
  final Function showSideBar;
  PaymentMain(this.showSideBar);

  @override
  _PaymentMainState createState() => _PaymentMainState();
}

class _PaymentMainState extends State<PaymentMain> {
  bool status = false;
  int payState = 1;

  finishPayment(){
    setState(() {
      status = true;
      payState = 1;
    });
    Future.delayed(Duration(milliseconds: 3000), (){
      setState(() {
        payState = 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        bgColorLayer(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context)/15),
              child: headingRole2(context, "Explore", fontSize: 15, togNav: widget.showSideBar, colorMain: colors.blueColor, canGoBack: true, solid: true),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(context)/12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      textControl("Choose your payment method", context, size: 18, fontWeight: FontWeight.w600, color: colors.blueColor3),
                      SizedBox(height: getSize(context, 15),),
                      offerCard(context, title: "Pink Nike Air Max", image: "https://pngimg.com/uploads/running_shoes/running_shoes_PNG5827.png"),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: getSize(context, 10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            textControl("Saved Cards", context, size: 15, color: colors.blueColor3, fontWeight: FontWeight.w600),
                            Row(
                              children: <Widget>[
                                textControl("Add card", context, size: 15, color: colors.blueColor3, fontWeight: FontWeight.w500),
                                Icon(Icons.add, size: getSize(context, 15), color: colors.blueColor3)
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: getSize(context, 5),),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: getSize(context, 20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(),
                            Row(
                              children: <Widget>[
                                circle(getSize(context, 5), color: colors.pinkColor),
                                SizedBox(width: getSize(context, 7),),
                                circle(getSize(context, 5), color:colors.pinkColor.withOpacity(0.28)),
                                SizedBox(width: getSize(context, 7),),
                                circle(getSize(context, 5), color: colors.pinkColor.withOpacity(0.28)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getSize(context, 10),),
                Container(
                  height: getSize(context, 290),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      paymentCard(context, isFirst: true, cardNum: "**76", cardType: "Mastercard"),
                      paymentCard(context, cardType: "Visa", cardNum: "**54"),
                    ],
                  ),
                ),
                SizedBox(height: getSize(context, 20),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          textControl("TOTAL", context, color: colors.deepPink, size: 11,fontWeight: FontWeight.bold, spacing: 5),
                          textControl("N10,000", context, color: colors.blueColor.withOpacity(0.8), size: 18,fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(height: getSize(context, 20),),
                      Hero(
                        tag: "makePayment",
                        child: Material(
                          type: MaterialType.transparency,
                          child: simpleButton("Finish", context, padH: double.infinity, onTap: finishPayment),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: getSize(context, 20),),
              ],
            ),
          ),
        ),
        alertViewer(context, status: status, closeAlert: (){
          setState(() {
            status = false;
          });
        }, child: payState == 1 ? Container(
          height: getSize(context, 150),
          child: Center(
            child: SpinKitChasingDots(
              size: getSize(context, 50),
              color: colors.blueColor,
            ),
          ),
        ) : paymentConfirmation(context))
      ],
    );
  }
}

Widget paymentConfirmation(BuildContext context){
  return Column(
    children: <Widget>[
      textControl("Payment successful", context, size: 17, fontWeight: FontWeight.w500, color: colors.blueColor3.withOpacity(0.9)),
      SizedBox(height: getSize(context, 15),),
      insertContent(context, height: 120, width: 120, borderRadius: 120, color: colors.greenColor2.withOpacity(0.3),
          child: insertContent(context, height: 70, width: 70, borderRadius: 70, color: colors.greenColor2,
              child: Icon(Icons.check, color: Colors.white, size: getSize(context, 40),)),),
      SizedBox(height: getSize(context, 30),),
      simpleButton("See your pinned Item", context, padH: double.infinity, onTap: (){
        Navigator.of(context).pushNamed("/explore");
      },
          color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w500, padV: 70, borderRadius: 70),
      SizedBox(height: getSize(context, 20),),
    ],
  );
}
