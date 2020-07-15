import 'package:flutter/material.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/offerCard.dart';
import 'package:spot_app/components/overViewCard.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class OfferDashboard extends StatefulWidget {
  const OfferDashboard(this.showSideBar);
  final Function showSideBar;

  @override
  _OfferDashboardState createState() => _OfferDashboardState();
}

class _OfferDashboardState extends State<OfferDashboard> {
  gotoDeals(String type){
    Navigator.of(context).pushNamed("/offerDeal", arguments: {"type": type});
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
                child: headingRole2(context, "My Offers", togNav: widget.showSideBar, colorMain: colors.blueColor),
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
                              context, "4", "Completed", colors.pinkColor, zero: true,
                            onTap: (){gotoDeals("completed");}
                          ),
                        ),
                        SizedBox(width: getSize(context, 15),),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: overViewCard(context, "2", "Pending", colors.blueDark, zero: true, onTap: (){gotoDeals("pending");}),
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
                          child: overViewCard(context, "2", "Listed", colors.blueColor, zero: true, onTap: (){gotoDeals("approved");}),
                        ),
                        SizedBox(width: getSize(context, 15),),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: newOfferButton(context, onTap: (){Navigator.of(context).pushNamed("/newOffer");}),
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
                            textControl("Recent Offers", context, size: getSize(context, 20), fontWeight: FontWeight.w700, color: colors.blueColor3),
                            Row(
                              children: <Widget>[
                                textControl("This week", context, color: colors.pinkColor, size: 13,fontWeight: FontWeight.w600),
                                Icon(Icons.keyboard_arrow_down, size: 12, color: colors.pinkColor,)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: getSize(context, 20),),
                        offerCard(context, date: "12-06-19", title: "Pink Nike Air Max", image: "https://cdn.pixabay.com/photo/2018/09/30/21/28/sneakers-3714729__340.jpg"),
                        offerCard(context, date: "12-06-19", title: "Pink Nike Air Max", image: "https://cdn.pixabay.com/photo/2018/09/30/21/28/sneakers-3714729__340.jpg"),
                        offerCard(context, date: "12-06-19", title: "Pink Nike Air Max", image: "https://cdn.pixabay.com/photo/2018/09/30/21/28/sneakers-3714729__340.jpg"),
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
