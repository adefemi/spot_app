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

class StoreDashboard extends StatelessWidget {
  const StoreDashboard(this.showSideBar);
  final Function showSideBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 17),
          child: SizedBox.expand(
            child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                appBarItem("Dashboard", "store.svg", active: true),
                appBarItem("My Offers", "cart.svg"),
                SizedBox(width: 50,),
                appBarItem("Chats", "chat.svg"),
                appBarItem("Scan", "barcode.svg"),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.white,
        elevation: 0,
        child: Transform.scale(scale: 1.2, child: SvgPicture.asset("assets/svgs/addNew.svg", color: colors.deepPink,),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            bgColorLayer(),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4.5),
              color: Colors.transparent,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height / 12,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 10),
                      child: textControl("Overview", fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height / 3.7 > 200 ? MediaQuery.of(context).size.height / 3.7 : 200 ,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          overViewCard(context, "8", "My Offers", colors.pinkColor, isFirst: true),
                          overViewCard(context, "20", "Chats", colors.blueDark),
                          overViewCard(context, "20", "Chats", colors.blueColor, isLast: true)
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 10),
                      child: textControl("All Metrics", fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height / 9 > 85 ? MediaQuery.of(context).size.height / 9 : 85,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          metricsCard(context, "2000", "Likes", colors.pinkColor, Icon(Icons.favorite, color: Colors.white,), isFirst: true),
                          metricsCard(context, "5000", "Pins", colors.blueColor, SvgPicture.asset("assets/svgs/pin.svg", color: Colors.white,),),
                          metricsCard(context, "20", "Chats", colors.blueDark, Icon(Icons.favorite, color: Colors.white,), isLast: true)
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 6,),
                  ],
                ),
              ),
            ),
            Container(
             height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                color: colors.blueColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60))
              ),
            ),
            Positioned(
              right: -MediaQuery.of(context).size.width/5,
              top: 50,
              child: Transform(
                transform: Matrix4.rotationZ(
                  -20 * 3.142/180
                ),
                child: Transform.scale(scale: 1.7, child: threeDots(context, color: Colors.white.withOpacity(0.05)),),
              ),
            ),
            Container(
             height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.008),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60))
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3.5,
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  headingRole2(context, "Hassan Stores", togNav: showSideBar),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      textControl("My Dashboard", size: 25, fontWeight: FontWeight.w700, color: Colors.white),
                      SizedBox(height: 10,),
                      circle(10, color: colors.pinkColor)
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

