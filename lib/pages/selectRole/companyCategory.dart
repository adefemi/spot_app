import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:place_picker/entities/entities.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/loader.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/sideBarLayer.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/models/errorHandler.dart';
import 'package:spot_app/network/customRequestHandler.dart';
import 'package:spot_app/network/data.dart';
import 'package:spot_app/network/dataMock.dart';
import 'package:spot_app/network/requestManage.dart';
import 'package:spot_app/pages/storePage/dashboardMain.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class CompanyCategory extends StatefulWidget {
  @override
  _CompanyCategoryState createState() => _CompanyCategoryState();
}

class _CompanyCategoryState extends State<CompanyCategory> {
  PageController _pageController = PageController();
  String category;
  Map categoryActive;
  bool loading = false;
  bool fetching = true;
  var categories = [];
  List<String> categoriesMain = [];

  void goNext(){
    if(category == null){
      Fluttertoast.showToast(msg: "Select a category to proceed...", backgroundColor: Colors.red, textColor: Colors.white);
      return;
    }
    setState(() {
      loading = true;
    });
    Map updateData = {
      "businessCategory": categoryActive,
    };
    updateUserData(updateData, setStateWithStatus, context, callback);
  }

  void setStateWithStatus(bool status){
    setState(() {
      loading = status;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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

  void callback(){
    _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void onSelectCat(val){
    var activeData;
    for(int i = 0; i<categories.length; i++){
      if(categories[i]["name"] == val){
        activeData = categories[i];
        break;
      }
    }
    setState(() {
      category = val;
      categoryActive = activeData;
    });
  }

//  void showPlacePicker() async {
//    LocationResult result = await Navigator.of(context).push(
//        MaterialPageRoute(builder: (context) => PlacePicker("AIzaSyA76l-3yAg-cJewJXW_xs9e2c0R5n40f7c",)));
//
//    // Handle the result in your way
//    print(result);
//  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
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
                        textControl("Merchant Account", context, size: getSize(context, 16),
                            color: colors.blueColor.withOpacity(0.8)),
                        SizedBox(height: getSize(context, 40),),
                        textControl("Company", context, size: getSize(context, 25), fontWeight: FontWeight.w500),
                        SizedBox(height: getSize(context, 10),),
                        textControl("Category", context, size: getSize(context, 25), fontWeight: FontWeight.w700),
                        SizedBox(height: getSize(context,10),),
                        circle(getSize(context, 10), color: colors.pinkColor),
                        SizedBox(height: getSize(context, 30),),
                        inputSelectField(context, placeholder: "Choose business category", value: category, onSelect: onSelectCat, borderRadius: 10, height: 50, itemList: categoriesMain),
                        SizedBox(height:getSize(context, 60),),
                        Center(
                          child:  Hero(
                            tag: "goCompanySelect",
                            child: Material(
                              type: MaterialType.transparency,
                              child: simpleButton("Finish", context,
                                  color: Colors.white.withOpacity(0.9),
                                  loading: loading,
                                  fontWeight: FontWeight.w500, onTap: goNext),
                            ),
                          ),
                        ),
                        SizedBox(height:getSize(context, 50),),
                      ],
                    ),
                  ),
                ),
                loaderMain(context, status: fetching),
//                Column(
//                  children: <Widget>[
//                    SizedBox(height: 500,),
//                    FlatButton(
//                      child: Text("Pick Delivery location"),
//                      onPressed: () {
//                        showPlacePicker();
//                      },
//                    ),
//                  ],
//                )
              ],
            ),
          ),
        ),
        SideBarControl((Function showSideBar) => Dashboard(showSideBar)),
      ],
    );
  }
}



