import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/offerCard.dart';
import 'package:spot_app/components/offerClaimCard.dart';
import 'package:spot_app/components/offerTab.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class History extends StatefulWidget {
  const History(this.showSideBar);
  final Function showSideBar;

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

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
                                textControl("History", context, size: 25, fontWeight: FontWeight.bold, color: colors.blueColor3),
                                insertContent(context, color: colors.blueColor3, child: Icon(Icons.list, color: Colors.white,), borderRadius: 10)
                              ],
                            ),
                            SizedBox(height: getSize(context, 5),),
                            circle(getSize(context, 8), color: colors.pinkColor),
                            SizedBox(height: getSize(context, 20),),
                            textInputField(context, placeholder: "Search", height: 67),
                            SizedBox(height: getSize(context, 20),),
                            textControl("Location visited | 2", context, size: 20, fontWeight: FontWeight.bold, color: colors.blueColor3),
                            SizedBox(height: getSize(context, 20),),
                            offerClaimCard(context, image: "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", title: "Alice A",
                                date: textControl("Claimed on 12-06-2019", context, size: 11, color: Colors.black.withOpacity(0.3))),
                            offerClaimCard(context, image: "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", title: "Alice A",
                                date: textControl("Claimed on 12-06-2019", context, size: 11, color: Colors.black.withOpacity(0.3))),
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
