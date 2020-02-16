import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/models/options.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';

class OtpSetup extends StatefulWidget {
  @override
  _OtpSetupState createState() => _OtpSetupState();
}

class _OtpSetupState extends State<OtpSetup> {
  bool disabled = true;
  int activeIndex = 1;
  String otp = "";
  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();
  FocusNode myFocusNode3 = FocusNode();
  FocusNode myFocusNode4 = FocusNode();

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
                    textControl("Verify", size: 25, fontWeight: FontWeight.w500),
                    SizedBox(height: 10,),
                    textControl("Phone Number", size: 25, fontWeight: FontWeight.w700),
                    SizedBox(height: 10,),
                    circle(10, color: colors.pinkColor),
                    SizedBox(height: 40,),
                    textControl("Enter 4 digit pin sent to your number", size: 15, font: fonts.proxima),
                    SizedBox(height: 20,),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Flexible(
                          child: otpInputField(isFocused: activeIndex == 1, onChange: (val){
                            onChange(1, val);
                          }, otpFocusNode: myFocusNode1, isFirst: true),
                        ),
                        SizedBox(width: 15,),
                        Flexible(
                          child: otpInputField(isFocused: activeIndex == 2, onChange: (val){
                            onChange(2, val);
                          }, otpFocusNode: myFocusNode2),
                        ),
                        SizedBox(width: 15,),
                        Flexible(
                          child: otpInputField(isFocused: activeIndex == 3, onChange: (val){
                            onChange(3, val);
                          }, otpFocusNode: myFocusNode3),
                        ),
                        SizedBox(width: 15,),
                        Flexible(
                          child: otpInputField(isFocused: activeIndex == 4, onChange: (val){
                            onChange(4, val);
                          }, otpFocusNode: myFocusNode4),
                        )
                      ],
                    ),
                    SizedBox(height: 60,),
                   Center(
                     child:  Stack(
                       children: <Widget>[
                         Hero(
                           tag:"goOTP",
                           child: simpleButton("Veri", padH: 60),
                         ),
                         Hero(
                           tag:"goAbout",
                           child: Consumer<UserOnBoardChangeNotifierModel>(
                             builder: (context, model, child){
                               return simpleButton("Verify",
                                   color: Colors.white.withOpacity(0.9),
                                   padH: 60,
                                   backColor: disabled ? Colors.grey : colors.blueColor,
                                   fontWeight: FontWeight.w500,
                                   onTap: (){
                                     if(disabled){
                                       Fluttertoast.showToast(msg: "Provide/Complete OTP ");
                                     }else{
                                       if(model.activeRole == spotRoles.merchant){
                                         Navigator.of(context).pushNamed("/aboutCompany");
                                       }
                                       else{
                                         Navigator.of(context).pushNamed("/aboutUser");
                                       }

                                     }
                                   }
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
                          child: textControl("Change Number", size: 15, color: colors.pinkColor, underline: true, font: fonts.proxima),
                        ),
                        textControl("Resend Pin", size: 15, color: colors.pinkColor, underline: true, font: fonts.proxima)
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



