import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/loader.dart';
import 'package:spot_app/components/offerCard.dart';
import 'package:spot_app/components/offerTab.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/network/customRequestHandler.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class OfferDeal extends StatefulWidget {
  const OfferDeal(this.showSideBar);
  final Function showSideBar;

  @override
  _OfferDealState createState() => _OfferDealState();
}

class _OfferDealState extends State<OfferDeal> {
  String active = "";
  Map<String, dynamic> deals = {};
  bool fetching = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100), (){
      Map args = ModalRoute.of(context).settings.arguments;
      setState(() {
        active = args["type"];
      });
      fetchDealsMain(args["type"]);
    });
  }

  onChangeTab(String type){
    setState(() {
      active = type;
    });
    fetchDealsMain(type);
  }

  fetchDealsMain(String type) async{
    if(type.toUpperCase() == "COMPLETED"){
      setState(() {
        deals = {
          "data": [],
          "recordsFiltered": 0
        };
        fetching = false;
      });
    }
    else{
      setState(() {
        fetching = true;
      });
      dynamic _deals = await fetchDeals(context, extra: "?status=${type.toUpperCase()}", full: true);
      setState(() {
        deals = _deals;
        fetching = false;
      });
    }

  }

  List<Widget> getDeals(){
    List<Widget> _tempHolder = [];
    for(int i = 0; i<(deals["data"].length > 5 ? 5 : deals["data"].length); i++){
      _tempHolder.add(
          offerCard(context, date: deals["data"][i]["startDate"], title: deals["data"][i]["title"], image: deals["data"][i]["images"][0])
      );
    }
    return _tempHolder;
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
                    child: headingRole2(context, "${StringUtils.capitalize(active)} Offers", togNav: widget.showSideBar, colorMain: colors.blueColor, canGoBack: true),
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
                            textControl("${StringUtils.capitalize(active)}", context, size: 25, color: colors.blueColor3),
                            Row(
                              children: <Widget>[
                                textControl("Offers", context, size: 25, fontWeight: FontWeight.bold, color: colors.blueColor3),
                                SizedBox(width: 5,),
                                textControl("| ${fetching ? 0 : deals["recordsFiltered"]}", context, size: 25, color: colors.blueColor3),
                              ],
                            ),
                            SizedBox(height: getSize(context, 5),),
                            circle(getSize(context, 8), color: colors.pinkColor),
                            SizedBox(height: getSize(context, 20),),
                            Flex(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: offerTab(context, text: "Completed", active: active == "completed", onTap: (){onChangeTab("completed");}),
                                ),
                                SizedBox(width: getSize(context, 10),),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: offerTab(context, text: "Approved", activeColor: colors.orangeColor, active: active == "approved", onTap: (){onChangeTab("approved");}),
                                ),
                                SizedBox(width: getSize(context, 10),),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: offerTab(context, text: "Pending", activeColor: colors.blueColor, active: active == "pending", onTap: (){onChangeTab("pending");}),
                                ),
                              ],
                            ),
                            SizedBox(height: getSize(context, 30),),
                            fetching ? offerLoaders(context) : Column(children: getDeals(),),
                            SizedBox(height: getSize(context, 50),),
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
