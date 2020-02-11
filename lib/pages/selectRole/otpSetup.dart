import 'package:flutter/material.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/countrySelect.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/selectRoleBox.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';

class OtpSetup extends StatefulWidget {
  @override
  _OtpSetupState createState() => _OtpSetupState();
}

class _OtpSetupState extends State<OtpSetup> {
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
                    headingRole(context),
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
                          child: otpInputField(),
                        ),
                        SizedBox(width: 15,),
                        Flexible(
                          child: otpInputField(),
                        ),
                        SizedBox(width: 15,),
                        Flexible(
                          child: otpInputField(),
                        ),
                        SizedBox(width: 15,),
                        Flexible(
                          child: otpInputField(),
                        )
                      ],
                    ),
                    SizedBox(height: 60,),
                   Center(
                     child:  simpleButton("Verify",
                         color: Colors.white.withOpacity(0.9),
                         padH: 60,
                         fontWeight: FontWeight.w500),
                   ),
                    SizedBox(height: 60,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        textControl("Change Number", size: 15, color: colors.pinkColor, underline: true, font: fonts.proxima),
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



