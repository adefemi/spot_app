import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:spot_app/components/alertViewer.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/exploreCard.dart';
import 'package:spot_app/components/exploreView.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/offerCard.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/network/customRequestHandler.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

class Explore extends StatefulWidget {
  const Explore(this.showSideBar);
  final Function showSideBar;

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> with TickerProviderStateMixin {

  String activeInterest = "";
  bool status = false;
  bool fetching = true;
  Map<String, dynamic> activeDeal = {};
  List<dynamic> deals = [];

  gotoDeal({String id: ""}){
    Navigator.of(context).pushNamed("/productView", arguments: {"id": id});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeals();
  }

  void getDeals() async {
    UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
    setState(() {
      activeInterest = userOnBoardChangeNotifierModel.activeCat["name"];
    });
    String extra = "?categoryId=${userOnBoardChangeNotifierModel.activeCat["id"]}";
    List<dynamic> _deals = await fetchDeals(context, extra: extra);
    printWrapped(_deals.toString());
    setState(() {
      deals = _deals;
      fetching = false;
    });
  }

  setActiveProduct(e){
    setState(() {
      activeDeal = e;
      status = true;
    });
  }

  goChat(){
    Navigator.of(context).pushNamed("/chatPad");
  }

  List<Widget> getDealContent(){
    List<Widget> _tempHolder = [];
    for(int i = 0; i<deals.length; i++){
      _tempHolder.add(
          exploreCard(context, image: deals[i]["images"][0], onChat: goChat, onView: () => gotoDeal(id: deals[i]["id"]), cat: activeInterest,
              name: deals[i]["title"], price: "N${deals[i]["amount"]}", onPin: (e) => setActiveProduct(deals[i]))
      );
    }
    if(_tempHolder.length < 1){
      _tempHolder.add(
        Container(
            width: getWidth(context),
            height: getHeight(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getSize(context, 30)),
              color: Colors.white,
            ),
            child: Center(
              child: textControl("We couldn't find any deals", context),
            ),
        )
      );
    }
    return _tempHolder;
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
                    child: headingRole2(context, "Explore", fontSize: 15, togNav: widget.showSideBar, colorMain: colors.blueColor, canGoBack: true, solid: true),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                body: fetching ? SkeletonAnimation(
                  child: Container(
                    width: getWidth(context),
                    height: getHeight(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(getSize(context, 30)),
                      color: Colors.grey[300],
                    ),
                  ),
                )
                    : ExploreView(getDealContent(), context, deals.length < 1 ? false : true)
            ),
            alertViewer(context, status: status, closeAlert: (){
              setState(() {
                status = false;
              });
            }, child: productConfirmation(context, activeDeal: activeDeal, interest: activeInterest))
          ],
        ),
      ),
    );
  }
}

Widget productConfirmation(BuildContext context, {String interest = "", Map<String, dynamic> activeDeal}){
  if(activeDeal["id"] == null){
    return SizedBox();
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      textControl("Summary", context, fontWeight: FontWeight.w600, size: 17, color: colors.blueColor3),
      SizedBox(height: getSize(context, 20),),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          insertContent(context, width: 100, height:35, borderRadius: 35,
              child: textControl(interest, context,color: Colors.white, size: 13, fontWeight: FontWeight.w500, font: fonts.proxima)),
          textControl("Listed ${activeDeal["startDate"]}", context, size: 13, color: Colors.black.withOpacity(0.3), font: fonts.proxima, fontWeight: FontWeight.w500),
        ],
      ),
      SizedBox(height: getSize(context, 20),),
      offerCard(context, title: activeDeal["title"], image: activeDeal["images"][0]),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          textControl("TOTAL", context, color: colors.deepPink.withOpacity(0.6), size: 11,fontWeight: FontWeight.bold, spacing: 5),
          textControl("N${activeDeal["amount"]}", context, color: colors.blueColor.withOpacity(0.8), size: 18,fontWeight: FontWeight.bold),
        ],
      ),
      SizedBox(height: getSize(context, 20),),
      Hero(
        tag: "makePayment",
        child: Material(
          type: MaterialType.transparency,
          child: simpleButton("Make Payment",
              context, color: Colors.white.withOpacity(0.9), onTap: (){
                Navigator.of(context).pushNamed("/payment", arguments: {"id": activeDeal["id"]});
              },
              padH: double.infinity),
        ),
      ),
      SizedBox(height: getSize(context, 20),),
    ],
  );
}
