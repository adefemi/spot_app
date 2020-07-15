import 'package:flutter/material.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/fileSelector.dart';
import 'package:spot_app/components/formGroup.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/settingsItem.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/models/options.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

class CompanyProfile extends StatelessWidget {
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
                            textControl("Hassan Stores", context, size: 20, fontWeight: FontWeight.w600),
                            SizedBox(width: getSize(context, 15),),
                            textControl("Offered deals: 65", context, size: 15, font: fonts.proxima, color: colors.blueColor.withOpacity(0.5)),
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
                        textInputField(context, borderRadius: getSize(context, 16), height: getSize(context, 67), placeholder: "Name, eg. Alien Consult", onChange: (val){

                        },),
                      label: "Company Name"
                    ),
                    formGroup(context,
                        GestureDetector(
                          onTap: (){},
                          child: fileSelector(context),
                        ),
                      label: "Company Logo"
                    ),
                    formGroup(context,
                        textInputField(context, borderRadius: getSize(context, 16), height: getSize(context, 67), onChange: (val){

                        },),
                      label: "Location"
                    ),
                    formGroup(context,
                        inputSelectField(context, placeholder: "Choose business category", value: null, onSelect: (val){}, borderRadius: 16, height: 75, itemList: spotCompanyCategory),
                      label: "Business category"
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
