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

class AboutUser extends StatefulWidget {
  @override
  _AboutUserState createState() => _AboutUserState();
}

class _AboutUserState extends State<AboutUser> {
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
                    textControl("Tell us", size: 25, fontWeight: FontWeight.w500),
                    SizedBox(height: 10,),
                    textControl("About Yourself", size: 25, fontWeight: FontWeight.w700),
                    SizedBox(height: 10,),
                    circle(10, color: colors.pinkColor),
                    SizedBox(height: 40,),
                    textControl("Name", size: 15, font: fonts.proxima),
                    SizedBox(height: 20,),
                    otpInputField(borderRadius: 16, height: 67),
                    SizedBox(height: 30,),
                    textControl("Gender", size: 15, font: fonts.proxima),
                    SizedBox(height: 20,),
                    Container(
                      height: 200,
                      child: Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          selectRoleBox("assets/pngs/role2.png", "Male"),
                          selectRoleBox("assets/pngs/female.png", "Female", first: false, imageWidth: 80),
                        ],
                      ),
                    ),
                    SizedBox(height:100,),
                   Center(
                     child:  simpleButton("Continue",
                         color: Colors.white.withOpacity(0.9),
                         padH: 60,
                         fontWeight: FontWeight.w500),
                   ),
                    SizedBox(height:50,),
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



