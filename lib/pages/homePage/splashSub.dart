import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:spot_app/components/splashControl.dart';
import 'package:spot_app/components/splashSubComponent.dart';
import 'package:spot_app/components/splashText.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/pages/selectRole/selectRole.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashSub extends StatefulWidget {
  @override
  _SplashSubState createState() => _SplashSubState();
}

class _SplashSubState extends State<SplashSub> {

  ScrollController _scrollController = ScrollController();
  int scrollState = 0;

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void switchScreen(){
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
          MediaQuery.of(context).size.width / 1.24 * scrollState,
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

  @override
  Widget build(BuildContext context) {
    final splashContentHeight = MediaQuery.of(context).size.height/2.2;
    return SizedBox.expand(
      child: Scaffold(
        backgroundColor: colors.lightBlur,
        body: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    color: colors.blueColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    )
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: threeDots(context),
                      right: MediaQuery.of(context).size.width / 8,
                      top: -50,
                    ),
                    Positioned(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed("/roleSelect");
                        },
                        child: Text("Skip", style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: fonts.proxima
                        ),),
                      ),
                      right: 40,
                      top: MediaQuery.of(context).size.height/15,
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width ,
                height: splashContentHeight,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height/6),
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
                      top: MediaQuery.of(context).size.height/6),
                  height: splashContentHeight,
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: Image.asset(
                        _imageList[scrollState], width: 350,
                        key:  ValueKey(scrollState),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Center(
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                child: splashText(
                                    _contentList[scrollState],
                                    key: ValueKey(scrollState)
                                ),
                              ),
                            ),
                            Center(
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                child: splashText(_contentList[scrollState],
                                    head: false,
                                    key: ValueKey(scrollState)
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/15,),

                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width / 9
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
                                    child: GestureDetector(
                                      onTap: scrollState == 2 ? (){
                                        Navigator.of(context).pushNamed("/roleSelect");
                                      } :goNext,
                                      child: Container(
                                        width: 118,
                                        height: 62,
                                        decoration: BoxDecoration(
                                            color: colors.blueColor,
                                            borderRadius: BorderRadius.circular(40)
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.chevron_right,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ),
                            SizedBox(height: 20,)
                          ],
                        ),
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
