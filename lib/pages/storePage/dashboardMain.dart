import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:spot_app/components/appBarItem.dart';
import 'package:spot_app/network/customRequestHandler.dart';
import 'package:spot_app/pages/chatPage/chatDashboard.dart';
import 'package:spot_app/pages/offerPage/offerDashboard.dart';
import 'package:spot_app/pages/storePage/dashboard.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class Dashboard extends StatefulWidget {
  const Dashboard(this.showSideBar);
  final Function showSideBar;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int activePage = 0;
  PageController _pageController = PageController();
  Map<String, dynamic> userData;

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
    setState(() {
      userData = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false).userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(onWillPop: () => willPopController(context),
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
                  appBarItem("Dashboard", context, "store.svg", active: activePage == 0 ? true: false, onTap: (){changePage(0);}),
                  appBarItem("My Offers", context, "cart.svg", active: activePage == 1 ? true: false, onTap: (){changePage(1);}),
                  SizedBox(width: getSize(context, 50),),
                  appBarItem("Chats", context,  "chat.svg", active: activePage == 2 ? true: false, onTap: (){changePage(2);}),
                  appBarItem("Scan", context, "barcode.svg", onTap: ()=>gotoPage(context, "/barcodeScanner", repNamed: false)),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).pushNamed("/newOffer");
          },
          backgroundColor: Colors.white,
          elevation: 0,
          child: Transform.scale(scale: 1.2, child: SvgPicture.asset("assets/svgs/addNew.svg", color: colors.deepPink,),),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            StoreDashboard(widget.showSideBar, userData),
            OfferDashboard(widget.showSideBar),
            ChatDashboard(widget.showSideBar),
          ],
        ),
      ));
  }
}
