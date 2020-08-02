import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/offerCard.dart';
import 'package:spot_app/components/overViewCard.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/network/customRequestHandler.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
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
  Map<String, dynamic> interestSummary = {};
  bool fetchingSummary = true;

  gotoDeals(String type, String catId){
    UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
    userOnBoardChangeNotifierModel.setActiveCatId({
      "name": type,
      "id": catId
    });
    Navigator.of(context).pushNamed("/explore");
  }

  gotoDeal(int id){
    Navigator.of(context).pushNamed("/singleOfferDeal");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInterestSummary();
  }

  getInterestSummary() async{
    String interestId = "";
    List<dynamic> interestObj = activeUser(context, content: "interests") as List<dynamic>;
    for(int i = 0; i<interestObj.length; i++){
      interestId += interestObj[i]["id"].toString();
      if(i != interestObj.length - 1){
        interestId += ", ";
      }
    }
    List<dynamic> data = await fetchDealsSummary(context, "?interests=$interestId");
    Map<String, dynamic> _tempSummary = {};
    for(int j = 0; j<data.length; j++){
      _tempSummary[data[j]["category"]] = data[j]["numberOfDeals"];
    }
    setState(() {
      interestSummary = _tempSummary;
      fetchingSummary = false;
    });
  }

  Color getColor(int index){
    List<dynamic> colorsList = [
      colors.pinkColor,
      colors.blueDark,
      colors.blueColor,
      colors.deepPink,
    ];
    try{
      return colorsList[index];
    }catch(e){
      return Colors.grey;
    }
  }

  List<Widget> getInterestBody(){
    List<Widget> _tempHolder = [];
    List<dynamic> userInterests = activeUser(context, content: "interests");

    int start = 0;
    int end = userInterests.length > 2 ? 2 : userInterests.length;
    int count = 0;
    for(int j = 0; j<userInterests.length; j++){
      count++;
      if(count == 1){
        _tempHolder.add(
            Container(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context)/15),
                height: getSize(context, 220),
                child: Flex(
                  direction: Axis.horizontal,
                  children: userInterests.sublist(start, end).asMap().map((i, e){
                    return MapEntry(i, Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        margin: EdgeInsets.only(
                            right: getSize(context, i == 0 ? 7.5 : 0),
                            left: getSize(context, i != 0 ? 7.5 : 0)
                        ),
                        child: overViewCard(
                            context, interestSummary[e["name"]] == null ? "0" : interestSummary[e["name"]].toString(), e["name"], getColor(j+i), zero: true, loading: fetchingSummary,
                            onTap: (){gotoDeals(e["name"], e["id"]);}
                        ),
                      ),
                    ));
                  }).values.toList(),
                )
            )
        );

        _tempHolder.add(SizedBox(height: getSize(context, 15),));
      }
      if(count == 2){
        start = start + count;
        end = userInterests.length > start + 2 ? start + 2 : userInterests.length;
        count = 0;
      }
    }

    return _tempHolder;
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
                child: headingRole2(context, activeUser(context, content: "name"), togNav: widget.showSideBar, colorMain: colors.blueColor, solid: true),
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
                  Column(
                    children: getInterestBody(),
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
