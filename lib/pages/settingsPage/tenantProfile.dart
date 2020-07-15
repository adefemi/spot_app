import 'package:flutter/material.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/fileSelector.dart';
import 'package:spot_app/components/formGroup.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/selectRoleBox.dart';
import 'package:spot_app/components/settingsItem.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/models/options.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

class TenantProfile extends StatefulWidget {
  @override
  _TenantProfileState createState() => _TenantProfileState();
}

class _TenantProfileState extends State<TenantProfile> {
  String _selectedGender;
  bool disabled = true;

  void _selectGender(gender){
    setState(() {
      _selectedGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(context)/15),
          child: headingRole2(context, "Profile", solid: true, canGoBack: true),
        ),
        elevation: 0,
        backgroundColor: colors.blueColor,
      ),
      backgroundColor: colors.lightBlue1,
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: -getSize(context, getWidth(context)/5),
                  top: getSize(context, 50),
                  child: circle(50, color: Colors.white.withOpacity(0.1))
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(getSize(context, 80))
                  ),
                  child: Container(
                    color: colors.blueColor,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: getSize(context, getWidth(context) / 8), vertical: getSize(context, 20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: getSize(context, 10),),
                        textControl("My Profile", context, color: Colors.white, size: 25, fontWeight: FontWeight.bold)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context)/7, vertical: getSize(context, 30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:NetworkImage("https://cdn.pixabay.com/photo/2016/08/28/13/12/secondlife-1625903_960_720.jpg"),
                          radius: getSize(context, 35),
                        ),
                        SizedBox(width: getSize(context, 15),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            textControl("Temi Alade", context, size: 20, fontWeight: FontWeight.w600),
                            SizedBox(width: getSize(context, 15),),
                            textControl("Closed deals: 30", context, size: 15, font: fonts.proxima, color: colors.blueColor.withOpacity(0.5)),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: getSize(context, 30),),
                    formGroup(context,
                      phoneInputField(context, value: "803 791 3530", isCorrect: true, setValue: (newValue){

                      } ),
                      label: "Phone number"
                    ),
                    formGroup(context,
                        Container(
                          height: getSize(context, 200),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: <Widget>[
                              selectRoleBox( context, "assets/svgs/spotter.svg",
                                  spotGenders.male,
                                  imageWidth: getSize(context, 30),
                                  active: _selectedGender == spotGenders.male,
                                  onTap: (){
                                    _selectGender(spotGenders.male);
                                    setState(() {
                                      disabled = false;
                                    });
                                  }

                              ),
                              selectRoleBox(context,
                                  "assets/svgs/female.svg",
                                  spotGenders.female,
                                  scaleFactor: 6.5,
                                  paddingTop: getSize(context, 90),
                                  first: false,
                                  imageWidth: getSize(context, 30),
                                  active: _selectedGender == spotGenders.female,
                                  onTap: (){
                                    _selectGender(spotGenders.female);
                                    setState(() {
                                      disabled = false;
                                    });
                                  }
                              ),
                            ],
                          ),
                        ),
                      label: "Gender"
                    ),

                    SizedBox(height: getSize(context, 15),),
                    Center(
                      child: simpleButton("Edit Profile", context),
                    )
                  ],
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}
