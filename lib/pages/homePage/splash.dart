import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/pages/homePage/splashSub.dart';
import 'package:spot_app/provider/systemMount.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  PageController _pageController = PageController();
  bool start = false;
  bool showLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        start = true;
      });
      moveNext();
    });
//    Future.delayed(const Duration(milliseconds: 1000), () {
//      setState(() {
//        showLoading = true;
//      });
//    });

    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void moveNext(){
    Future.delayed(const Duration(milliseconds: 1200), () {
      _pageController.animateToPage(1,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn);

    });
  }
  @override

  Widget build(BuildContext context) {

    return PageView(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: SizedBox.expand(
            child: Consumer<SystemMount>(
              builder: (context, model, child){
                if(model.roles != null){
                  moveNext();
                }
                return Stack(
                  children: <Widget>[
                    SizedBox.expand(
                      child: AnimatedContainer(
                        color: start ? colors.blueColor : colors.pinkColor,
                        duration: Duration(milliseconds: 500),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: !start ? null : Text("Spot", style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: fonts.playFairItalic,
                                  fontSize: getSize(context, 40)
                              ),),
                            ),
                            showLoading ? SizedBox(height: getSize(context, 10),) : SizedBox(),
                            showLoading ? Center(
                              child: SpinKitRing(
                                color: Colors.white,
                                size: getSize(context, 20),
                                lineWidth: 2,
                              ),
                            ) : SizedBox()
                          ],
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      child: threeDots(context),
                      bottom: start ? 0 : getHeight(context) - 200,
                      right: start ? -30 : getWidth(context) / 8,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        SplashSub()
      ],
    );
  }
}

// from top: -50, to bottom: 20
// from right: MediaQuery.of(context).size.width / 8, to right: -30