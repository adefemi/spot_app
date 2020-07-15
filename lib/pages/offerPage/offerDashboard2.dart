import 'package:flutter/material.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/offerCard.dart';
import 'package:spot_app/components/overViewCard.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class OfferDashboard2 extends StatefulWidget {
  final Function showSideBar;
  final Function changePage;
  const OfferDashboard2(this.showSideBar, {this.changePage});


  @override
  _OfferDashboard2State createState() => _OfferDashboard2State();
}

class _OfferDashboard2State extends State<OfferDashboard2> {
  gotoDeals(String type){
    Navigator.of(context).pushNamed("/explore", arguments: {"type": type});
  }

  gotoDeal(int id){
    Navigator.of(context).pushNamed("/singleOfferDeal");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: <Widget>[
          bgColorLayer(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context)/15),
                child: headingRole2(context, "Hello World", togNav: widget.showSideBar, colorMain: colors.blueColor, solid: true),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: getSize(context, 20),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
                    child: textControl("Offer", context, size: getSize(context, 25), fontWeight: FontWeight.w500, color: colors.blueColor3),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
                    child: textControl("My Offers", context, size: getSize(context, 25), fontWeight: FontWeight.w700, color: colors.blueColor3),
                  ),
                  SizedBox(height: getSize(context, 10),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
                    child: circle(getSize(context, 10), color: colors.pinkColor),
                  ),
                  SizedBox(height: getSize(context, 20),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(context)/15),
                    height: getSize(context, 220),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: overViewCard(
                              context, "4", "Sports", colors.pinkColor, zero: true,
                            onTap: (){gotoDeals("Sports");}
                          ),
                        ),
                        SizedBox(width: getSize(context, 15),),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: overViewCard(context, "2", "Electronics", colors.blueDark, zero: true, onTap: (){gotoDeals("Electronics");}),
                        ),
                      ],
                    )
                  ),
                  SizedBox(height: getSize(context, 15),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(context)/15),
                    height: getSize(context, 220),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: overViewCard(context, "1", "Automobiles", colors.blueColor, zero: true, onTap: (){gotoDeals("Automobiles");}),
                        ),
                        SizedBox(width: getSize(context, 15),),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: SizedBox(),
                        ),
                      ],
                    )
                  ),
                  SizedBox(height: getSize(context, 30),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            textControl("My Pinned Offers | 20", context, size: getSize(context, 20), fontWeight: FontWeight.w700, color: colors.blueColor3),
                            GestureDetector(
                              onTap: (){
                                widget.changePage(1);
                              },
                              child: textControl("See all", context, color: colors.pinkColor, size: 13,fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(height: getSize(context, 20),),
                        offerCard(context, title: "Pink Nike Air Max", image: "https://cdn.pixabay.com/photo/2018/09/30/21/28/sneakers-3714729__340.jpg", onTap: (){gotoDeal(1);}),
                        offerCard(context, title: "Pink Nike Air Max", image: "https://cdn.pixabay.com/photo/2018/09/30/21/28/sneakers-3714729__340.jpg"),
                        offerCard(context, title: "Pink Nike Air Max", image: "https://cdn.pixabay.com/photo/2018/09/30/21/28/sneakers-3714729__340.jpg"),
                        SizedBox(height: getSize(context, 100),),
                      ],
                    ),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}
