import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_app/components/appBarItem.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/metricsCard.dart';
import 'package:spot_app/components/overViewCard.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class StoreDashboard extends StatelessWidget {
  const StoreDashboard(this.showSideBar, this.userData);
  final Function showSideBar;
  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        bgColorLayer(),
        Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context)/15),
              child: headingRole2(context, userData["companyName"], togNav: showSideBar, avatar: userData["logo"]),
            ),
            elevation: 0,
            backgroundColor: colors.blueColor,
          ),
          backgroundColor: Colors.transparent,
          body: SizedBox.expand(
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        right: -getSize(context, getWidth(context)/5),
                        top: getSize(context, 50),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              -getSize(context, 20) * 3.142/180
                          ),
                          child: Transform.scale(scale: getSize(context, 1.7), child: threeDots(context, color: Colors.white.withOpacity(0.05)),),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(getSize(context, 50))
                        ),
                        child: Container(
                          color: colors.blueColor,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: getSize(context, getWidth(context) / 10), vertical: getSize(context, 20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              textControl("My Dashboard", context, size: getSize(context, 25), fontWeight: FontWeight.w700, color: Colors.white),
                              SizedBox(height: getSize(context, 10),),
                              circle(getSize(context, 10), color: colors.pinkColor)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Container(
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: getSize(context, 20)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: getWidth(context) / 10),
                              child: textControl("Overview", context, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: getSize(context, 20),),
                            Container(
                              height: getSize(context, 200) ,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  overViewCard(context, "8", "My Offers", colors.pinkColor, isFirst: true),
                                  overViewCard(context, "20", "Chats", colors.blueDark),
                                  overViewCard(context, "20", "Chats", colors.blueColor, isLast: true)
                                ],
                              ),
                            ),
                            SizedBox(height: getSize(context, 30),),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: getWidth(context) / 10),
                              child: textControl("All Metrics", context, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: getSize(context, 20),),
                            Container(
                              height: getSize(context, 85),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  metricsCard(context, "2000", "Likes", colors.pinkColor, Icon(Icons.favorite, color: Colors.white, size:getSize(context, 20)), isFirst: true),
                                  metricsCard(context, "5000", "Pins", colors.blueColor, SvgPicture.asset("assets/svgs/pin.svg", color: Colors.white, width: getSize(context, 18), height: getSize(context, 18),),),
                                  metricsCard(context, "20", "Chats", colors.blueDark, Icon(Icons.favorite, color: Colors.white, size:getSize(context, 20)), isLast: true)
                                ],
                              ),
                            ),
                            SizedBox(height: getHeight(context) / 6,),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

