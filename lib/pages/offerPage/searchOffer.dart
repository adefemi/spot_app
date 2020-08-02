import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/searchPanel.dart';
import 'package:spot_app/components/sideBarLayer2.dart';
import 'package:spot_app/network/customRequestHandler.dart';
import 'package:spot_app/pages/storePage/dashboardMain2.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class SearchOffer extends StatefulWidget {
  const SearchOffer(this.showSideBar);
  final Function showSideBar;

  @override
  _SearchOfferState createState() => _SearchOfferState();
}

class _SearchOfferState extends State<SearchOffer> {
  PageController _controller = PageController();
  void moveToPage(){
    _controller.animateToPage(1, duration: Duration(milliseconds: 700), curve: Curves.easeIn);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UserOnBoardChangeNotifierModel>(
      builder: (context, model, child){
        return Stack(
          children: <Widget>[
            bgColorLayer(),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: PageView(
                scrollDirection: Axis.vertical,
                controller: _controller,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: getWidth(context)/10, right: getWidth(context)/10, top: getSize(context, 30), bottom: getSize(context, 20)),
                        child: headingRole2(context, StringUtils.capitalize(activeUser(context, content: "name")), colorMain: colors.blueColor3, solid: true, togNav: widget.showSideBar),
                      ),
                      SearchPanel(moveToPage: moveToPage,),
                    ],
                  ),
                  SideBarControl2((Function showSideBar) => Dashboard2(showSideBar))
                ],
              )
            )
          ],
        );
      },
    );
  }
}
