import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/loader.dart';
import 'package:spot_app/components/mallCard.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/network/customRequestHandler.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';
import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

class Mall extends StatefulWidget {
  const Mall(this.showSideBar);
  final Function showSideBar;

  @override
  _MallState createState() => _MallState();
}

class _MallState extends State<Mall> {
  List<dynamic> malls = [];
  bool fetching = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMalls();
  }

  getMalls() async {
    List<dynamic> cont = await fetchMalls(context);
    print(cont);
    setState(() {
      malls = cont;
      fetching = false;
    });
  }

  List<Widget> defineMalls(){
    List<Widget> _tempHolder = [];
    for(int i = 0; i<malls.length; i++){
      DateTime dateTime = dateFormat.parse(malls[i]["createdAt"]);
      _tempHolder.add(
        mallCard(context, malls[i]["createdAt"].length.toString(),StringUtils.capitalize( malls[i]["label"]), DateFormat('yyyy-MM-dd').format(dateTime) ),
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
                    child: headingRole2(context, StringUtils.capitalize(activeUser(context, content: "name")), togNav: widget.showSideBar, colorMain: colors.blueColor, solid: true),
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
                                textControl("Malls", context, size: 25, fontWeight: FontWeight.bold, color: colors.blueColor3),
                                insertContent(context, color: colors.blueColor3, child: Icon(Icons.list, color: Colors.white,), borderRadius: 10)
                              ],
                            ),
                            SizedBox(height: getSize(context, 5),),
                            circle(getSize(context, 8), color: colors.pinkColor),
                            SizedBox(height: getSize(context, 20),),
                            textInputField(context, placeholder: "Search", height: 67),
                            SizedBox(height: getSize(context, 20),),
                            textControl("All Malls | ${fetching ? "" : malls.length}", context, size: 20, fontWeight: FontWeight.bold, color: colors.blueColor3),
                            SizedBox(height: getSize(context, 20),),
                            fetching ? Column(
                              children: <Widget>[
                                offerLoader(context, height: 200),
                                SizedBox(height: getSize(context, 20),),
                                offerLoader(context, height: 200),
                                SizedBox(height: getSize(context, 20),),
                              ],
                            ) :
                            Column(
                              children: defineMalls(),
                            ),
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
