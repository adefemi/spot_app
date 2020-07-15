import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/models/errorHandler.dart';
import 'package:spot_app/models/options.dart';
import 'package:spot_app/network/data.dart';
import 'package:spot_app/network/requestManage.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

class OtpSetup extends StatefulWidget {
  @override
  _OtpSetupState createState() => _OtpSetupState();
}

class _OtpSetupState extends State<OtpSetup> {
  bool disabled = false;
  int activeIndex = 1;
  String otp = "";
  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();
  FocusNode myFocusNode3 = FocusNode();
  FocusNode myFocusNode4 = FocusNode();
  bool loading = false;

  void onChange(int node, value){
    if(value.length > 0){
      int newActiveIndex = activeIndex;
      switch(activeIndex){
        case 1:
          FocusScope.of(context).requestFocus(myFocusNode2);
          newActiveIndex = 2;
          break;
        case 2:
          FocusScope.of(context).requestFocus(myFocusNode3);
          newActiveIndex = 3;
          break;
        default:
          FocusScope.of(context).requestFocus(myFocusNode4);
          newActiveIndex = 4;
      }
      String nVal = value;
      if(otp.length > node-1){
        nVal = nVal + otp.substring(node-1, otp.length);
      }
      final otpValue = otp.substring(0, node - 1) + nVal;
      setState(() {
        otp = otpValue;
        activeIndex = newActiveIndex;
        disabled = otpValue.length >= 4 ? false : true;
      });
    }
    else{
      final otpValue = otp.substring(0, node - 1) + otp.substring(node, otp.length);
      setState(() {
        otp = otpValue;
        disabled = otpValue.length < 4 ? true : false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void submit(Function callback, UserOnBoardChangeNotifierModel model) async {
    callback();
    return;
    setState(() {
      loading = true;
    });
    // verify phone number
    Map verificationData = {
      "value": model.phoneNumber,
      "type": "phone",
      "withToken": "true",
      "code": otp
    };

    HttpRequests httpRequests = HttpRequests(url: networkData.getVerifyCodeUrl(), body: verificationData, headers: networkData.headers );
    final response = await httpRequests.post();
    ErrorHandler errorHandler = ErrorHandler(response: response);

    if(!errorHandler.hasError){
      final Map jsonResult = json.decode(response.body) as Map;
      Map userData = jsonResult["data"]["user"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      prefs.setString(spotPrefs.token, jsonResult["data"]["token"].toString());
      prefs.setString(spotPrefs.spotId, userData["id"].toString());
      prefs.setString(spotPrefs.userId, userData["userId"].toString());
      callback();
    }
    else{
      Fluttertoast.showToast(msg: errorHandler.errorMessage ,backgroundColor: Colors.red.withOpacity(0.7), textColor: Colors.white);
      setState(() {
        loading = false;
      });
    }


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
                    textControl("Verify", context, size: getSize(context, 25), fontWeight: FontWeight.w500),
                    SizedBox(height: getSize(context, 10),),
                    textControl("Phone Number", context, size: getSize(context, 25), fontWeight: FontWeight.w700),
                    SizedBox(height: getSize(context, 10),),
                    circle(getSize(context, 10), color: colors.pinkColor),
                    SizedBox(height: getSize(context, 40),),
                    textControl("Enter 4 digit pin sent to your number", context, size: getSize(context, 15), font: fonts.proxima),
                    SizedBox(height: getSize(context, 20),),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Flexible(
                          child: otpInputField(context, isFocused: activeIndex == 1, onChange: (val){
                            onChange(1, val);
                          }, otpFocusNode: myFocusNode1, isFirst: true),
                        ),
                        SizedBox(width: getSize(context, 15),),
                        Flexible(
                          child: otpInputField(context, isFocused: activeIndex == 2, onChange: (val){
                            onChange(2, val);
                          }, otpFocusNode: myFocusNode2),
                        ),
                        SizedBox(width: getSize(context, 15),),
                        Flexible(
                          child: otpInputField(context, isFocused: activeIndex == 3, onChange: (val){
                            onChange(3, val);
                          }, otpFocusNode: myFocusNode3),
                        ),
                        SizedBox(width: getSize(context, 15),),
                        Flexible(
                          child: otpInputField(context, isFocused: activeIndex == 4, onChange: (val){
                            onChange(4, val);
                          }, otpFocusNode: myFocusNode4),
                        )
                      ],
                    ),
                    SizedBox(height: getSize(context, 60),),
                   Center(
                     child:  Stack(
                       children: <Widget>[
                         Hero(
                           tag:"goOTP",
                           child: Material(
                             type: MaterialType.transparency,
                             child: simpleButton("Veri", context, padH: 0, padV: 0),
                           ),
                         ),
                         Hero(
                           tag:"goAbout",
                           child: Consumer<UserOnBoardChangeNotifierModel>(
                             builder: (context, model, child){
                               return Material(
                                 type: MaterialType.transparency,
                                 child: simpleButton("Verify", context,
                                     color: Colors.white.withOpacity(0.9),
                                     backColor: disabled ? Colors.grey : colors.blueColor,
                                     loading: loading,
                                     fontWeight: FontWeight.w500,
                                     onTap: (){
                                        if(loading)return;
                                       if(disabled){
                                         Fluttertoast.showToast(msg: "Provide/Complete OTP ");
                                       }else{
                                         if(model.activeRole == spotRoles.merchant){
                                           submit(() => Navigator.of(context).pushNamed("/aboutCompany"), model);
                                         }
                                         else{
                                           submit(() =>  Navigator.of(context).pushNamed("/aboutUser"), model);
                                         }

                                       }
                                     }
                                 ),
                               );
                             }
                           ),
                         )
                       ],
                     )
                   ),
                    SizedBox(height: 60,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){Navigator.of(context).pop();},
                          child: textControl("Change Number", context, size: 15, color: colors.pinkColor, underline: true, font: fonts.proxima),
                        ),
                        textControl("Resend Pin", context, size: 15, color: colors.pinkColor, underline: true, font: fonts.proxima)
                      ],
                    )
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



