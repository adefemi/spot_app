import 'package:flutter/material.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/sideBarLayer.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/models/options.dart';
import 'package:spot_app/pages/storePage/dashboard.dart';
import 'package:spot_app/utils/colors.dart';

class CompanyCategory extends StatefulWidget {
  @override
  _CompanyCategoryState createState() => _CompanyCategoryState();
}

class _CompanyCategoryState extends State<CompanyCategory> {
  PageController _pageController = PageController();
  String category;

  void goNext(){
    _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
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
                      horizontal: MediaQuery.of(context).size.width / 10
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 50,),
                        headingRole(context, canGoBack: true),
                        SizedBox(height: 40,),
                        textControl("Merchant Account", size: 16,
                            color: colors.blueColor.withOpacity(0.8)),
                        SizedBox(height: 40,),
                        textControl("Company", size: 25, fontWeight: FontWeight.w500),
                        SizedBox(height: 10,),
                        textControl("Category", size: 25, fontWeight: FontWeight.w700),
                        SizedBox(height: 10,),
                        circle(10, color: colors.pinkColor),
                        SizedBox(height: 30,),
                        inputSelectField( placeholder: "Choose business category", value: category, onSelect: onSelectCat, borderRadius: 16, height: 75, itemList: spotCompanyCategory),
                        SizedBox(height:60,),
                        Center(
                          child:  Hero(
                            tag: "goCompanySelect",
                            child: simpleButton("Finish",
                                color: Colors.white.withOpacity(0.9),
                                padH: 60,
                                fontWeight: FontWeight.w500, onTap: goNext),
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
        ),
        SideBarControl((Function showSideBar) => StoreDashboard(showSideBar)),
      ],
    );
  }
}



