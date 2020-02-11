import 'package:flutter/material.dart';
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
                    textControl("Enter your", size: 25, fontWeight: FontWeight.w500),
                    SizedBox(height: 10,),
                    textControl("Phone Number", size: 25, fontWeight: FontWeight.w700),
                    SizedBox(height: 10,),
                    circle(10, color: colors.pinkColor),
                    SizedBox(height: 40,),

                    phoneInputField(),

                    SizedBox(height: 60,),
                   Center(
                     child:  simpleButton("Continue",
                         color: Colors.white.withOpacity(0.9),
                         fontWeight: FontWeight.w500),
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



