import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spot_app/components/splashControl.dart';
import 'package:spot_app/components/splashSubComponent.dart';
import 'package:spot_app/components/splashText.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/models/errorHandler.dart';
import 'package:spot_app/models/options.dart';
import 'package:spot_app/network/data.dart';
import 'package:spot_app/network/requestManage.dart';
import 'package:spot_app/pages/selectRole/selectRole.dart';
import 'package:spot_app/provider/systemMount.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_app/utils/helpers.dart';

class SplashSub extends StatefulWidget {
  @override
  _SplashSubState createState() => _SplashSubState();
}

class _SplashSubState extends State<SplashSub> {

  ScrollController _scrollController = ScrollController();
  int scrollState = 0;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void switchScreen(){
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
          getWidth(context) / 1.24 * scrollState,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn
      );

    });
  }

  void goNext(){
    setState(() {
      scrollState = scrollState + 1;
    });

    switchScreen();
  }

  void onTapControl(int scrollPoint){
    setState(() {
      scrollState = scrollPoint;
    });

    switchScreen();
  }

  List<Map<String, String>> _contentList = [
    {
      "head": "Spot great deal offers",
      "content": "close to you"
    },
    {
      "head": "Swipe, like and pin",
      "content": "favorite offers"
    },
    {
      "head": "Chat up merchants &",
      "content": "close on pinned offers"
    },
  ];

  List<String> _imageList = [
    "assets/pngs/splashIcon2.png",
    "assets/pngs/splashIcon1.png",
    "assets/pngs/splashIcon3.png",
  ];

  void moveToPhoneSetup() async {
    navigateToSetUp();
  }

  void navigateToSetUp(){
    Navigator.of(context).pushNamed("/roleSelect");
  }

  @override
  Widget build(BuildContext context) {
    final splashContentHeight = getSize(context, getHeight(context)/getSize(context, 2));
    return Scaffold(
      backgroundColor: colors.lightBlur.withOpacity(0.98),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Container(
              height: getHeight(context) / 3,
              decoration: BoxDecoration(
                  color: colors.blueColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(getSize(context, 100)),
                    bottomRight: Radius.circular(getSize(context, 100)),
                  )
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: threeDots(context),
                    right:  getWidth(context)/ 8,
                    top: -getSize(context, 50),
                  ),
                  Positioned(
                    child: GestureDetector(
                      onTap: moveToPhoneSetup,
                      child: loading ? SpinKitRing(
                        color: Colors.white,
                        size: getSize(context, 20),
                        lineWidth: 2,
                      ) : Text("Skip", style: TextStyle(
                          color: Colors.white,
                          fontSize: getSize(context, 16),
                          fontFamily: fonts.proxima
                      ),),
                    ),
                    right: getSize(context, 40),
                    top: getHeight(context)/15,
                  )
                ],
              ),
            ),
            Container(
              height: splashContentHeight,
              margin: EdgeInsets.only(
                  top: getHeight(context)/6),
              child: SizedBox.expand(
                child: ListView(
                  controller: _scrollController,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    splashSubComponent(context, first: true),
                    splashSubComponent(context),
                    splashSubComponent(context, last: true),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Container(
                margin: EdgeInsets.only(
                    top: getHeight(context)/6),
                height: splashContentHeight,
                child: Center(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: Image.asset(
                      _imageList[scrollState], width: getSize(context, 350),
                      key:  ValueKey(scrollState),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: getWidth(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Center(
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 500),
                              child: splashText(
                                  context,
                                  _contentList[scrollState],
                                  key: ValueKey(scrollState)
                              ),
                            ),
                          ),
                          Center(
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 500),
                              child: splashText(context, _contentList[scrollState],
                                  head: false,
                                  key: ValueKey(scrollState)
                              ),
                            ),
                          ),
                          SizedBox(height: getHeight(context)/15,),

                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context) / 9
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    splashControl((){onTapControl(0);}, active: scrollState == 0 && true),
                                    splashControl((){onTapControl(1);},active: scrollState == 1 && true),
                                    splashControl((){onTapControl(2);},active: scrollState == 2 && true),
                                  ],
                                ),
                                Hero(
                                  tag: "goRole",
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: GestureDetector(
                                      onTap: scrollState == 2 ? (){
                                        moveToPhoneSetup();
                                      } :goNext,
                                      child: Container(
                                        width: getSize(context, 118),
                                        height: getSize(context, 62),
                                        decoration: BoxDecoration(
                                            color: colors.blueColor,
                                            borderRadius: BorderRadius.circular(getSize(context, 40))
                                        ),
                                        child: Center(
                                          child: loading ? SpinKitRing(
                                            color: Colors.white,
                                            size: getSize(context, 20),
                                            lineWidth: 2,
                                          ) : Icon(
                                            Icons.chevron_right,
                                            color: Colors.white,
                                            size: getSize(context, 30),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                          SizedBox(height: getSize(context, 20),)
                        ],
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
