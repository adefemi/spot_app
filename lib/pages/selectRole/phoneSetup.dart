import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/network/data.dart';
import 'package:spot_app/network/requestManage.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class PhoneSetup extends StatefulWidget {
  @override
  _PhoneSetupState createState() => _PhoneSetupState();
}

class _PhoneSetupState extends State<PhoneSetup> {
  String value = "";
  bool isCorrect = true;
  String countryCode = "234";

  void submit(Function callback){
    callback();
    return;
    String newValue = countryCode + value.replaceAll(" ", "");
    Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false).setPhoneNumber(newValue);

    // verify phone number
    Map verificationData = {
      "value": newValue,
      "type": "phone",
      "createIfNotExist": "true"
    };

    HttpRequests httpRequests = HttpRequests(url: networkData.getVerifyPhoneUrl(), body: verificationData, headers: networkData.headers );
    httpRequests.post();
    callback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child:  Stack(
          children: <Widget>[
            bgColorLayer(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: getWidth(context) / 10
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: getSize(context, 50),),
                    headingRole(context, canGoBack: true),
                    SizedBox(height: getSize(context, 40),),
                    textControl("Spotter Account", context, size: getSize(context, 16), color: colors.blueColor.withOpacity(0.8)),
                    SizedBox(height: getSize(context, 40),),
                    textControl("Enter your", context, size: getSize(context, 25), fontWeight: FontWeight.w500),
                    SizedBox(height: getSize(context, 10),),
                    textControl("Phone Number", context, size: getSize(context, 25), fontWeight: FontWeight.w700),
                    SizedBox(height: getSize(context, 10),),
                    circle(getSize(context, 10), color: colors.pinkColor),
                    SizedBox(height: getSize(context, 40),),

                    phoneInputField(context, value: value, isCorrect: isCorrect, setValue: (newValue){
                      setState(() {
                        value = newValue;
                        isCorrect = newValue.length >= 12;
                      });
                    } ),

                    SizedBox(height: getSize(context, 60),),
                   Center(
                     child:  Stack(
                       children: <Widget>[
                         Hero(
                           tag: "goPhone",
                           child: Material(
                             child: Material(
                               type: MaterialType.transparency,
                               child: simpleButton("Conti", context, padH: 0, padV: 0),
                             ),
                           ),
                         ),
                         Hero(
                           tag: "goOTP",
                           child: Material(
                             type: MaterialType.transparency,
                             child: simpleButton("Continue", context,
                                 color: Colors.white.withOpacity(0.9),
                                 backColor: !isCorrect ? Colors.grey : colors.blueColor,
                                 fontWeight: FontWeight.w500,
                               onTap: (){
                                 if(!isCorrect){
                                   Fluttertoast.showToast(msg: "Phone number entry not complete");
                                 }
                                 else{
                                   // call verify phone end point
                                   submit(() => Navigator.of(context).pushNamed("/otpSetup"));
                                 }
                               }
                             ),
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



