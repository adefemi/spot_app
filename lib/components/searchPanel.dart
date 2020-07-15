import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/offerCard2.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

class SearchPanel extends StatefulWidget {
  final Function moveToPage;
  SearchPanel({this.moveToPage});

  @override
  _SearchPanelState createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> with TickerProviderStateMixin {
  bool searching = false;
  bool searchingStated = false;
  bool searchStatus = false;
  AnimationController rotationController;
  bool canGo = true;


  @override
  void initState() {
    rotationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
    startSearch();
  }

  startSearch(){
    setState(() {
      searching = false;
      searchStatus = false;
      searchingStated = true;
      canGo = false;
    });
    Future.delayed(Duration(milliseconds: 2000), (){
      rotationController.forward(from: 0.0);
      setState(() {
        searching = true;
        searchStatus = true;
        canGo = true;
      });
      Future.delayed(Duration(milliseconds: 3000), (){
        if(canGo){
          widget.moveToPage();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint){
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: getSize(context, 50),),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 1,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    margin: EdgeInsets.only(
                        top: getSize(context, 50)
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
                          topLeft: Radius.circular(getSize(context, 50)),
                          topRight: Radius.circular(getSize(context, 50)),
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: getSize(context, 20),),
                        Center(
                          child: Container(
                            width: getWidth(context) / 6,
                            height: 3,
                            decoration: BoxDecoration(
                                color: Colors.grey[300]
                            ),
                          ),
                        ),
                        SizedBox(height: getSize(context, 20),),
                        Center(child: textControl("Radar Activated", context, size: 20, fontWeight: FontWeight.w500)),
                        SizedBox(height: getSize(context, 10),),
                        Center(
                          child: searchStatus ? insertContent(context, width: getSize(context, 120),
                              color: Colors.black.withOpacity(0.05), borderRadius: getSize(context, 40), onTap: startSearch,
                              child: textControl("Search Again", context, size: 13, fontWeight: FontWeight.w600, font: fonts.proxima, color: Colors.black.withOpacity(0.5))) :
                          textControl("Currently searching for offers near you", context,
                              size: getSize(context, 14), color: colors.blueColor.withOpacity(0.5)),
                        ),
                        SizedBox(height: getSize(context, 40),),
                        searchRadar(context, rotationController, searching),
                        !searchingStated ?
                        Column(
                          children: <Widget>[
                            SizedBox(height: getSize(context, 70),),
                            Center(
                              child: simpleButton("Search for Offers", context,
                                  onTap: startSearch,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.gps_fixed, color: Colors.white, size: 17,),
                                      SizedBox(width: getSize(context, 5),),
                                      textControl("Search for Offers", context, size: 17, color: Colors.white, font: fonts.proxima, fontWeight: FontWeight.w500)
                                    ],
                                  )),
                            ),
                            SizedBox(height: getSize(context, 30),)
                          ],
                        ) :
                        searching ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: getSize(context, 50),),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  textControl("Offer Categories", context, size: 20, color: colors.blueColor3, fontWeight: FontWeight.bold),
                                  GestureDetector(
                                    onTap: (){Navigator.of(context).pushNamed("/dashboard");},
                                    child: textControl("view all", context, size: 13, color: colors.pinkColor, fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: getSize(context, 20),),
                            Container(
                              height: getSize(context, 180),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  offerCard2(context, "4", "Sports", colors.pinkColor, SvgPicture.asset("assets/svgs/baseball.svg", color: colors.pinkColor.withOpacity(0.2),), isFirst: true),
                                  offerCard2(context, "2", "Automobiles", colors.blueColor, SvgPicture.asset("assets/svgs/car.svg", color: colors.blueColor.withOpacity(0.2))),
                                  offerCard2(context, "1", "Electronics", colors.blueColor2, SvgPicture.asset("assets/svgs/tv.svg", color: colors.blueColor2.withOpacity(0.2)), isLast: true),
                                ],
                              ),
                            ),
                            SizedBox(height: getSize(context, 20),),
                          ],
                        ) : SizedBox(height: getSize(context, 100),),
                        SizedBox(height: getSize(context, 20),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget searchRadar(BuildContext context, AnimationController animationController, bool searching){
  final screenWidth = getWidth(context);
  return Container(
    height: getHeight(context) / 2.5,
    child: Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: radar(
            context,
              width: screenWidth / 1.5,
              radarCircles: [
                radarCircle(context, top: getSize(context, 60), left: getSize(context, 100), color: colors.blueColor.withOpacity(0.2)),
                radarCircle(context, top: getSize(context, 100), left: getSize(context, 10), color: colors.blueColor.withOpacity(0.2)),
                searching ? radarCircle(context, top: getSize(context, 20), left: getSize(context, 200)) : SizedBox(),
              ]
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: radar(context,
              width: screenWidth / 2.5,
              radarCircles: [
                radarCircle(context, top: getSize(context, 60), left: getSize(context, 100), color: colors.blueColor.withOpacity(0.2)),
                searching ? radarCircle(context, top: getSize(context, 100), left: getSize(context, 10)) : SizedBox()
              ]
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: radar(context, width: screenWidth / 7),
        ),
        searching ? Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: getSize(context, 77),
            width: getSize(context, 77),
            child: Center(
              child: textControl("7", context, size: getSize(context, 18),
                  fontWeight: FontWeight.w600, color: Colors.white),
            ),
            decoration: BoxDecoration(
                color: colors.pinkColor,
                borderRadius: BorderRadius.circular(getSize(context, 25)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, getSize(context, 50)),
                      color: colors.pinkColor.withOpacity(0.2),
                      spreadRadius: getSize(context, 20),
                      blurRadius: getSize(context, 50)
                  )
                ]
            ),
          ),
        ) : SizedBox(),
        Align(
          alignment: Alignment.center,
          child: RotationTransition(
            turns: Tween(begin: 0.0, end: 0.3).animate(animationController),
            child: searchPoint(context),
          )
        )
      ],
    ),
  );
}

Widget radar(BuildContext context, {double width: 20, List<Widget> radarCircles}) => Container(
  width: getSize(context, width),
  height: getSize(context, width),
  child: Stack(
    children: radarCircles == null ? [] : radarCircles,
  ),
  decoration: BoxDecoration(
      color: Colors.black.withOpacity(0),
      borderRadius: BorderRadius.circular(getSize(context, width)),
      border: Border.all(
          width: 0.5,
          color: colors.radarBlue
      )
  ),
);

Widget radarCircle(BuildContext context, {double top:1, double left: 1, Color color}) => Positioned(
  top: getSize(context, top),
  left: getSize(context, left),
  child: circle(getSize(context, 12), color: color == null ? colors.pinkColor : color)
);

Widget searchPoint(BuildContext context){
  return Stack(
    children: <Widget>[
      Align(
        alignment: Alignment.center,
        child: Transform(
          transform: Matrix4.translationValues(
              getWidth(context) / 5,
              -getWidth(context) / 5 + 5, 0),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            key: ValueKey(35),
            child: Transform(
              transform: Matrix4.rotationZ((-35 * 3.142/180)),
              alignment: Alignment.bottomLeft,
              child: Container(
                height: getWidth(context) / 2.5,
                width: getWidth(context) / 2.5,
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
        child: circle(getSize(context, 12), color: colors.pinkColor),
      )
    ],
  );
}