import 'package:flutter/material.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';

Widget searchPanel(BuildContext context){
  return SizedBox.expand(
    child: AnimatedContainer(
      duration: Duration(milliseconds: 500),
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 7,
          left: 2, right: 2
      ),
      decoration: BoxDecoration(
          color: colors.searchWhite,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.02),
                spreadRadius: 10,
                blurRadius: 10
            )
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          )
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width / 6,
            height: 3,
            decoration: BoxDecoration(
                color: Colors.grey[300]
            ),
          ),
          SizedBox(height: 30,),
          textControl("Radar Activated", size: 20, fontWeight: FontWeight.w500),
          SizedBox(height: 10,),
          textControl("Currently searching for offers near you",
              size: 14, color: colors.blueColor.withOpacity(0.5)),
          SizedBox(height: 50,),
          searchRadar(context)
        ],
      ),
    ),
  );
}

Widget searchRadar(BuildContext context){
  final screenWidth = MediaQuery.of(context).size.width;
  return Container(
    height: MediaQuery.of(context).size.width / 1.2,
    child: Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: radar(
              width: screenWidth / 1.5,
              radarCircles: [
                radarCircle(top: 60, left: 100, color: colors.blueColor.withOpacity(0.2)),
                radarCircle(top: 100, left: 10, color: colors.blueColor.withOpacity(0.2)),
                radarCircle(top: 20, left: 200),
              ]
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: radar(
              width: screenWidth / 2.5,
              radarCircles: [
                radarCircle(top: 60, left: 100, color: colors.blueColor.withOpacity(0.2)),
                radarCircle(top: 100, left: 10),
              ]
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: radar(width: screenWidth / 7),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 77,
            width: 77,
            child: Center(
              child: textControl("1", size: 18,
                  fontWeight: FontWeight.w600, color: Colors.white),
            ),
            decoration: BoxDecoration(
                color: colors.pinkColor,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 50),
                    color: colors.pinkColor.withOpacity(0.2),
                    spreadRadius: 20,
                    blurRadius: 50
                  )
                ]
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: searchPoint(context),
        )
      ],
    ),
  );
}

Widget radar({double width: 20, List<Widget> radarCircles}) => Container(
  width: width,
  height: width,
  child: Stack(
    children: radarCircles == null ? [] : radarCircles,
  ),
  decoration: BoxDecoration(
      color: Colors.black.withOpacity(0),
      borderRadius: BorderRadius.circular(width),
      border: Border.all(
          width: 0.5,
          color: colors.radarBlue
      )
  ),
);

Widget radarCircle({double top:1, double left: 1, Color color}) => Positioned(
  top: top,
  left: left,
  child: circle(12, color: color == null ? colors.pinkColor : color)
);

Widget searchPoint(BuildContext context){
  return Stack(
    children: <Widget>[
      Align(
        alignment: Alignment.center,
        child: Transform(
          transform: Matrix4.translationValues(
              MediaQuery.of(context).size.width / 5,
              -MediaQuery.of(context).size.width / 5 + 5, 0),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            key: ValueKey(35),
            child: Transform(
              transform: Matrix4.rotationZ((-35 * 3.142/180)),
              alignment: Alignment.bottomLeft,
              child: Container(
                height: MediaQuery.of(context).size.width / 2.5,
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          colors.radarSearch.withOpacity(0.7),
                          colors.radarSearch.withOpacity(0),
                          Colors.white.withOpacity(0)
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight
                    )
                ),
              ),
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: circle(12, color: colors.pinkColor),
      )
    ],
  );
}