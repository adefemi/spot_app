import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/selectRoleBox.dart';
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

const errorTextMain = "This field is required";

class AboutUser extends StatefulWidget {
  @override
  _AboutUserState createState() => _AboutUserState();
}

class _AboutUserState extends State<AboutUser> {
  String _selectedGender;
  bool disabled = true;
  bool loading = false;
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

  void submit(Function callback) async{
    callback();
    return;
    // update user data
    Map updateData = {
      "name": userName,
      "gender": _selectedGender,
      "roleId": Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false).activeRoleId
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(spotPrefs.token);
    String userId = prefs.getString(spotPrefs.userId);
    Map<String, String> headers = networkData.setHeader(userBearer: true, userJson: true, token: token);
    String newUrl = networkData.getUsersUrl() + "/$userId";
    HttpRequests httpRequests = HttpRequests(url: newUrl, body: jsonEncode(updateData), headers: headers);
    setState(() {
      loading = true;
    });
    final response = await httpRequests.put();
    ErrorHandler errorHandler = ErrorHandler(response: response);
    if(!errorHandler.hasError){
      Map jsonResult = json.decode(response.body);
       Map<String, dynamic> userData = {};
       userData.addAll(jsonResult["data"]["profile"]);
       userData["meta"] = null;
       userData.addAll(jsonResult["data"]["profile"]["meta"]);
       Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false).setUserData(userData);
      callback();
      setState(() {
        loading = false;
      });
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
                    textControl("Tell us", context, size: getSize(context, 25), fontWeight: FontWeight.w500),
                    SizedBox(height: getSize(context, 10),),
                    textControl("About Yourself", context, size: getSize(context, 25), fontWeight: FontWeight.w700),
                    SizedBox(height: getSize(context, 10),),
                    circle(getSize(context, 10), color: colors.pinkColor),
                    SizedBox(height: getSize(context, 40),),
                    textControl("Name", context, size: getSize(context, 15), font: fonts.proxima),
                    SizedBox(height: getSize(context, 20),),
                    textInputField(context, borderRadius: getSize(context, 16), height: getSize(context, 67), placeholder: "Enter name, eg. Temi", focusNode: inputFocus, onChange: onChange, errorText: errorText),
                    SizedBox(height: getSize(context, 30),),
                    textControl("Gender", context, size: getSize(context, 15), font: fonts.proxima),
                    SizedBox(height: getSize(context, 20),),
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
                    SizedBox(height:getSize(context, 50),),
                   Center(
                     child:  Stack(
                       children: <Widget>[
                         Hero(
                           tag:"goAbout",
                           child: Material(
                             type: MaterialType.transparency,
                             child: simpleButton("Continue", context,
                                 color: Colors.white.withOpacity(0.9),
                                 backColor: disabled ? Colors.grey : colors.blueColor,
                                 fontWeight: FontWeight.w500,
                               loading: loading,
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
                                submit(() => Navigator.of(context).pushNamed("/userInterest"));
                               }
                             ),
                           ),
                         )
                       ],
                     ),
                   ),
                    SizedBox(height:getSize(context, 50),),
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



