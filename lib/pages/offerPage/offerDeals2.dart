import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/offerCard.dart';
import 'package:spot_app/components/offerTab.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class OfferDeal2 extends StatefulWidget {
  const OfferDeal2(this.showSideBar);
  final Function showSideBar;

  @override
  _OfferDeal2State createState() => _OfferDeal2State();
}

class _OfferDeal2State extends State<OfferDeal2> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  gotoDeal(int id){
    Navigator.of(context).pushNamed("/singleOfferDeal");
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            bgColorLayer(),
            Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  titleSpacing: 0,
                  automaticallyImplyLeading: false,
                  title: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(context)/15),
                    child: headingRole2(context, "Hello world", togNav: widget.showSideBar, colorMain: colors.blueColor, canGoBack: true, solid: true),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: getSize(context, 35),),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                textControl("Pinned", context, size: 25, fontWeight: FontWeight.bold, color: colors.blueColor3),
                                insertContent(context, color: colors.blueColor3, child: Icon(Icons.list, color: Colors.white,), borderRadius: 10)
                              ],
                            ),
                            SizedBox(height: getSize(context, 5),),
                            circle(getSize(context, 8), color: colors.pinkColor),
                            SizedBox(height: getSize(context, 20),),
                            textInputField(context, placeholder: "Search", height: 67),
                            SizedBox(height: getSize(context, 20),),
                            textControl("All Pinned Offers | 27", context, size: 20, fontWeight: FontWeight.bold, color: colors.blueColor3),
                            SizedBox(height: getSize(context, 20),),
                            offerCard(context, date: "20 mins left", title: "Pink Nike Air Max", image: "https://cdn.pixabay.com/photo/2018/09/30/21/28/sneakers-3714729__340.jpg", onTap: (){gotoDeal(1);}),
                            offerCard(context, date: "20 mins left", title: "Pink Nike Air Max", image: "https://cdn.pixabay.com/photo/2018/09/30/21/28/sneakers-3714729__340.jpg", onTap: (){gotoDeal(1);}),
                            offerCard(context, date: "20 mins left", title: "Pink Nike Air Max", image: "https://cdn.pixabay.com/photo/2018/09/30/21/28/sneakers-3714729__340.jpg", onTap: (){gotoDeal(1);}),
                            offerCard(context, date: "20 mins left", title: "Pink Nike Air Max", image: "https://cdn.pixabay.com/photo/2018/09/30/21/28/sneakers-3714729__340.jpg", onTap: (){gotoDeal(1);}),
                            offerCard(context, date: "20 mins left", title: "Pink Nike Air Max", image: "https://cdn.pixabay.com/photo/2018/09/30/21/28/sneakers-3714729__340.jpg", onTap: (){gotoDeal(1);}),
                            offerCard(context, date: "20 mins left", title: "Pink Nike Air Max", image: "https://cdn.pixabay.com/photo/2018/09/30/21/28/sneakers-3714729__340.jpg", onTap: (){gotoDeal(1);}),
                            SizedBox(height: getSize(context, 30),),
                          ],
                        ),
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
