import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_app/components/appBarItem.dart';
import 'package:spot_app/network/customRequestHandler.dart';
import 'package:spot_app/pages/chatPage/chatDashboard.dart';
import 'package:spot_app/pages/offerPage/history.dart';
import 'package:spot_app/pages/offerPage/offerDashboard2.dart';
import 'package:spot_app/pages/offerPage/offerDeals2.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class Dashboard2 extends StatefulWidget {
  const Dashboard2(this.showSideBar);
  final Function showSideBar;

  @override
  _Dashboard2State createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {
  int activePage = 0;
  PageController _pageController = PageController();

  changePage(int index){
    _pageController.jumpToPage(index);
    setState(() {
      activePage = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1), (){
      Map args = ModalRoute.of(context).settings.arguments;
      if(args != null){
        changePage(args["page"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPopController(context),
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 5.0,
          child: Container(
            height: getSize(context, 70),
            padding: EdgeInsets.symmetric(horizontal: getWidth(context) / 17),
            child: SizedBox.expand(
              child: Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  appBarItem("offers", context, "park.svg", active: activePage == 0 ? true: false, onTap: (){changePage(0);}),
                  appBarItem("Pinned", context, "pin.svg", active: activePage == 1 ? true: false, onTap: (){changePage(1);}),
                  SizedBox(width: getSize(context, 50),),
                  appBarItem("Chats", context,  "chat.svg", active: activePage == 2 ? true: false, onTap: (){changePage(2);}),
                  appBarItem("History", context, "history.svg", active: activePage == 3 ? true: false, onTap: (){changePage(3);}),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).pushNamed("/searchOffer");
          },
          backgroundColor: Colors.white,
          elevation: 0,
          child: Transform.scale(scale: 1.2, child: SvgPicture.asset("assets/svgs/gps.svg", color: colors.deepPink,),),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            OfferDashboard2(widget.showSideBar, changePage: changePage,),
            OfferDeal2(widget.showSideBar),
            ChatDashboard(widget.showSideBar),
            History(widget.showSideBar)
          ],
        ),
      ),
    );
  }
}
