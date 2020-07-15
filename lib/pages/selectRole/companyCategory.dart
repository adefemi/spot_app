import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/sideBarLayer.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/models/options.dart';
import 'package:spot_app/pages/storePage/dashboard.dart';
import 'package:spot_app/pages/storePage/dashboardMain.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class CompanyCategory extends StatefulWidget {
  @override
  _CompanyCategoryState createState() => _CompanyCategoryState();
}

class _CompanyCategoryState extends State<CompanyCategory> {
  PageController _pageController = PageController();
  String category;
  bool loading = false;

  void goNext(){
//    if(category == null){
//      Fluttertoast.showToast(msg: "Select a category to proceed...", backgroundColor: Colors.red, textColor: Colors.white);
//      return;
//    }
    setState(() {
      loading = true;
    });
    Future.delayed(Duration(milliseconds: 1000), (){
      setState(() {
        loading = false;
      });
      _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    });

  }

  void onSelectCat(val){
    setState(() {
      category = val;
    });
  }

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
                        inputSelectField(context, placeholder: "Choose business category", value: category, onSelect: onSelectCat, borderRadius: 16, height: 75, itemList: spotCompanyCategory),
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
                )
              ],
            ),
          ),
        ),
        SideBarControl((Function showSideBar) => Dashboard(showSideBar)),
      ],
    );
  }
}



