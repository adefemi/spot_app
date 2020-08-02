import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/loader.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/selectRoleBox.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/models/errorHandler.dart';
import 'package:spot_app/models/options.dart';
import 'package:spot_app/network/customRequestHandler.dart';
import 'package:spot_app/network/data.dart';
import 'package:spot_app/network/requestManage.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

const interestList = [
  "Sports", "Automobiles", "Electronics", "Beauty", "Health", "Food & Drinks", "Kiddies' Toys", "Real Estate", "Fashion"
];

class UserInterest extends StatefulWidget {
  @override
  _UserInterestState createState() => _UserInterestState();
}

class _UserInterestState extends State<UserInterest> {
  bool disabled = true;
  bool loading = false;
  bool fetching = true;
  String userName = "";
  List selectedInterest = [];
  String errorText;
  FocusNode inputFocus = FocusNode();
  var categories = [];
  List<String> categoriesMain = [];

  void onChange(val){
    setState(() {
      userName = val;
    });
  }

  void initState(){
    super.initState();
    setupCategories();
  }

  void setupCategories() async{
    Map data = await fetchCategories(context);
    setState(() {
      categories = data["data"];
      categoriesMain = data["newData"];
      fetching = false;
    });
  }

  void submit(Function callback) async{
    callback();
    return;
  }

  void toggleInterest(val){
    if(selectedInterest.contains(val)){
      selectedInterest.remove(val);
    }
    else{
      selectedInterest.add(val);
    }
    setState(() {
      selectedInterest = selectedInterest;
    });
  }

  void saveInterests(Function callBack){
    List selectedCategory = [];

    for(int i = 0; i<categories.length; i++){
      if(selectedInterest.contains(i)){
        selectedCategory.add(categories[i]);
      }
    }
    var data = {
      "interests": selectedCategory
    };
    updateUserData(data, setStateWithStatus, context, callBack);
  }

  void setStateWithStatus(bool status){
    setState(() {
      loading = status;
    });
  }

  List<Widget> getInterests(List interest){
    List<Widget> returnValue = [];
    for(int i = 0; i<interest.length; i++){
      bool isActive = selectedInterest.contains(i);
      returnValue.add(
        GestureDetector(
          onTap: (){
            toggleInterest(i);
          },
          child: Container(
            padding: EdgeInsets.all(getSize(context, 17)),
            margin: EdgeInsets.all(getSize(context, 10)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(getSize(context, 15))),
              color: isActive ? colors.pinkColor : colors.radarSearch.withOpacity(0.7),
            ),
            child: textControl(interest[i], context, size: 13, color: isActive ? Colors.white : Colors.black.withOpacity(0.7), font: fonts.proxima, fontWeight: FontWeight.w600 ),
          ),
        )
      );
    }
    return returnValue;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPopController(context),
      child: Stack(
        children: <Widget>[
          bgColorLayer(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidth(context) / 10
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: getSize(context, 50),),
                    headingRole(context, canGoBack: true, child: headingRole2(context, "Interests", canGoBack: true, colorMain: colors.blueColor)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getSize(context, 10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: getSize(context, 30),),
                          textControl("My Interests", context, size: getSize(context, 25), fontWeight: FontWeight.w700),
                          SizedBox(height: getSize(context, 10),),
                          circle(getSize(context, 10), color: colors.pinkColor),
                          SizedBox(height: getSize(context, 20),),
                        ],
                      ),
                    ),
                    textInputField(context, borderRadius: getSize(context, 16), height: getSize(context, 67), placeholder: "Search Interests", focusNode: inputFocus, onChange: onChange, errorText: errorText),
                    SizedBox(height: getSize(context, 30),),
                    Wrap(
                      children: getInterests(categoriesMain),
                    ),
                    SizedBox(height:getSize(context, 80),),
                    Center(
                        child:  simpleButton("Find Offers", context,
                            color: Colors.white,
                            backColor: colors.blueColor,
                            loading: loading,
                            fontWeight: FontWeight.w500,
                            disabled: selectedInterest.length < 1 || loading,
                            onTap: () => saveInterests(() => Navigator.of(context).pushReplacementNamed("/searchOffer"))
                        )
                    ),
                    SizedBox(height:getSize(context, 50),),
                  ],
                ),
              ),
            ),
          ),
          loaderMain(context, status: fetching)
        ],
      ),
    );
  }
}



