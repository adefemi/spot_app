import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/selectRoleBox.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/models/options.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';

const errorTextMain = "This field is required";

class AboutUser extends StatefulWidget {
  @override
  _AboutUserState createState() => _AboutUserState();
}

class _AboutUserState extends State<AboutUser> {
  String _selectedGender;
  bool disabled = true;
  String userName = "";
  String errorText;
  FocusNode inputFocus = FocusNode();

  void _selectGender(gender){
    setState(() {
      _selectedGender = gender;
    });
  }

  void onChange(val){
    setState(() {
      userName = val;
    });
  }

  void initState(){
    super.initState();
    inputFocus.addListener((){
      if(!inputFocus.hasFocus && userName.length < 1){
        setState(() {
          errorText = errorTextMain;
        });
      }
      else{
        setState(() {
          errorText = null;
        });
      }
    });
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
                    textControl("Tell us", size: 25, fontWeight: FontWeight.w500),
                    SizedBox(height: 10,),
                    textControl("About Yourself", size: 25, fontWeight: FontWeight.w700),
                    SizedBox(height: 10,),
                    circle(10, color: colors.pinkColor),
                    SizedBox(height: 40,),
                    textControl("Name", size: 15, font: fonts.proxima),
                    SizedBox(height: 20,),
                    textInputField(borderRadius: 16, height: 67, placeholder: "Enter name, eg. Temi", focusNode: inputFocus, onChange: onChange, errorText: errorText),
                    SizedBox(height: 30,),
                    textControl("Gender", size: 15, font: fonts.proxima),
                    SizedBox(height: 20,),
                    Container(
                      height: 200,
                      child: Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          selectRoleBox("assets/svgs/spotter.svg",
                              spotGenders.male,
                              imageWidth: MediaQuery.of(context).size.height / 25 > 30 ?
                              30 : MediaQuery.of(context).size.height / 25,
                              active: _selectedGender == spotGenders.male,
                              onTap: (){
                                _selectGender(spotGenders.male);
                                setState(() {
                                  disabled = false;
                                });
                              }

                          ),
                          selectRoleBox(
                              "assets/svgs/female.svg",
                              spotGenders.female,
                              scaleFactor: 6.5,
                              paddingTop: 90,
                              first: false,
                              imageWidth: MediaQuery.of(context).size.height / 25 > 30 ?
                              30 : MediaQuery.of(context).size.height / 25,
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
                    SizedBox(height:100,),
                   Center(
                     child:  Stack(
                       children: <Widget>[
                         Hero(
                           tag:"goAbout",
                           child: simpleButton("Continue",
                               color: Colors.white.withOpacity(0.9),
                               padH: 60,
                               backColor: disabled ? Colors.grey : colors.blueColor,
                               fontWeight: FontWeight.w500,
                             onTap: (){
                              if(disabled){
                                Fluttertoast.showToast(msg: "Fill in the required field to proceed");
                                return;
                              }
                              if(userName.length < 1){
                                setState(() {
                                  errorText = errorTextMain;
                                });
                                return;
                              }
                              Navigator.of(context).pushNamed("/searchOffer");
                             }
                           ),
                         )
                       ],
                     ),
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



