import 'package:flutter/material.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/selectRoleBox.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';

class SelectRole extends StatefulWidget {
  @override
  _SelectRoleState createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SizedBox.expand(
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
                    SizedBox(height: 50,),

                    textControl("Hello &", size: 25, fontWeight: FontWeight.w500),
                    SizedBox(height: 10,),
                    textControl("Welcome", size: 30, fontWeight: FontWeight.w700),
                    SizedBox(height: 10,),
                    circle(10, color: colors.pinkColor),
                    SizedBox(height: 30,),
                    textControl("Create your account", size: 20, fontWeight: FontWeight.w700),
                    SizedBox(height: 40,),
                    textControl("Select Role", size: 17, font: fonts.proxima, fontWeight: FontWeight.w500),
                    SizedBox(height: 20,),
                    Container(
                      height: 200,
                      child: Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          selectRoleBox("assets/pngs/role2.png", "Spotter"),
                          selectRoleBox("assets/pngs/role1.png", "Merchant", imageWidth: 60, first: false),
                        ],
                      ),
                    ),
                    SizedBox(height: 60,),
                   Center(
                     child:  simpleButton("Continue"),
                   ),
                    SizedBox(height: 20,),

                    Center(
                      child: textControl("Already have an account",
                          size: 16, font: fonts.proxima, color: colors.deepPink, underline: true),
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



