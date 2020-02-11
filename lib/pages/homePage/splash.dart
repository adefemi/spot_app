import 'package:flutter/material.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool start = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        start = true;
      });

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: AnimatedContainer(
                color: start ? colors.blueColor : colors.pinkColor,
                duration: Duration(milliseconds: 500),
                child: Center(
                  child: !start ? null : Text("Spot", style: TextStyle(
                    color: Colors.white,
                    fontFamily: fonts.playFairItalic,
                    fontSize: 40
                  ),),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              child: threeDots(context),
              bottom: start ? 0 : MediaQuery.of(context).size.height - 200,
              right: start ? -30 : MediaQuery.of(context).size.width / 8,
            ),
          ],
        ),
      ),
    );
  }
}

// from top: -50, to bottom: 20
// from right: MediaQuery.of(context).size.width / 8, to right: -30