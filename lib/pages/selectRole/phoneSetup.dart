import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';

class PhoneSetup extends StatefulWidget {
  @override
  _PhoneSetupState createState() => _PhoneSetupState();
}

class _PhoneSetupState extends State<PhoneSetup> {
  String value = "939939";
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child:  Stack(
          children: <Widget>[
            bgColorLayer(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 10
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 50,),
                    headingRole(context, canGoBack: true),
                    SizedBox(height: 40,),
                    textControl("Spotter Account", size: 16, color: colors.blueColor.withOpacity(0.8)),
                    SizedBox(height: 40,),
                    textControl("Enter your", size: 25, fontWeight: FontWeight.w500),
                    SizedBox(height: 10,),
                    textControl("Phone Number", size: 25, fontWeight: FontWeight.w700),
                    SizedBox(height: 10,),
                    circle(10, color: colors.pinkColor),
                    SizedBox(height: 40,),

                    phoneInputField(value: value, isCorrect: isCorrect, setValue: (newValue){
                      setState(() {
                        value = newValue;
                        isCorrect = newValue.length >= 12;
                      });
                    } ),

                    SizedBox(height: 60,),
                   Center(
                     child:  Stack(
                       children: <Widget>[
                         Hero(
                           tag: "goPhone",
                           child: simpleButton("Conti"),
                         ),
                         Hero(
                           tag: "goOTP",
                           child: simpleButton("Continue",
                               color: Colors.white.withOpacity(0.9),
                               backColor: !isCorrect ? Colors.grey : colors.blueColor,
                               fontWeight: FontWeight.w500,
                             onTap: (){
                               if(!isCorrect){
                                 Fluttertoast.showToast(msg: "Phone number entry not complete");
                               }
                               else{
                                 // call verify phone end point
                                 Navigator.of(context).pushNamed("/otpSetup");
                               }
                             }
                           ),
                         )
                       ],
                     ),
                   ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



