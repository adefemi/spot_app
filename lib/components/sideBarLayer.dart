import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/sideBarLinks.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_app/utils/helpers.dart';

class SideBarControl extends StatefulWidget {
  const SideBarControl(this._child);

  /// The clock widget with [ClockModel], to update and display.
  final _child;

  @override
  _SideBarControlState createState() => _SideBarControlState();
}

class _SideBarControlState extends State<SideBarControl> with TickerProviderStateMixin {

  final Tween tween = Tween<double>(
    begin: 1.0,
    end: 0.6
  );

  final Tween tween2 = Tween<double>(
    begin: 1.0,
    end: 0.5
  );
  Map<String, dynamic> userData;

  RelativeRectTween relativeRectTween = RelativeRectTween(
    begin: RelativeRect.fromLTRB(0, 0, 0, 0),
    end: RelativeRect.fromLTRB(0, 0, 0, 0),
  );

  RelativeRectTween relativeRectTween2 = RelativeRectTween(
    begin: RelativeRect.fromLTRB(0, 0, 0, 0),
    end: RelativeRect.fromLTRB(0, 0, 0, 0),
  );

  bool isOpen = false;
  AnimationController _controller;
  Animation<double> _animation;

  initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.ease);
    Future.delayed(Duration(milliseconds: 1), (){
      relativeRectTween = RelativeRectTween(
        begin: RelativeRect.fromLTRB(0, 0, 0, 0),
        end: RelativeRect.fromLTRB(0, 0, -MediaQuery.of(context).size.width/1.1, 0),
      );
      relativeRectTween2 = RelativeRectTween(
        begin: RelativeRect.fromLTRB(0, 0, 0, 0),
        end: RelativeRect.fromLTRB(0, 0, -MediaQuery.of(context).size.width/2.5, 0),
      );
    });
    setState(() {
      userData = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false).userData;
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  goBack(){
    setState(() {
      isOpen = false;
    });
    _controller.reverse();
  }

  openSideBar(){
    setState(() {
      isOpen = true;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            bgSideBar(),
            Positioned(
              bottom: -getSize(context, 150),
              right: getSize(context, 10),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(-getSize(context, 60) * 3.142/180),
                child: Transform.scale(scale: getSize(context, 1.5),
                  child: threeDots(context, color: Colors.white.withOpacity(0.05)),),),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidth(context) / 10
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: getHeight(context)/20,),
                      headingRole(context, isSideBar: true, goBack: goBack),
                    ],
                  ),
                  textControl(userData["companyName"] == null ? "" : userData["companyName"], context, size: getSize(context, 20), fontWeight: FontWeight.w600, color: Colors.white),
                 Column(
                   children: <Widget>[
                     sideBarLinks(
                         context,
                         icon: "store.svg",
                         title: "My Dashboard",
                         onTap: () => gotoPage(context, "/dashboard2")
                     ),
                     sideBarLinks(
                         context,
                         icon: "cart.svg",
                         title: "My Offers",
                         onTap: () => gotoPage(context, "/dashboard2", extra: 1)
                     ),
                     sideBarLinks(
                         context,
                         icon: "user.svg",
                         title: "Visiting Spotters",
                         onTap: () => gotoPage(context, "/visiting", repNamed: false)
                     ),
                     sideBarLinks(
                         context,
                         icon: "chat.svg",
                         title: "Chats",
                         onTap: () => gotoPage(context, "/dashboard2", extra: 2)
                     ),
                     sideBarLinks(
                         context,
                         icon: "barcode.svg",
                         title: "Scan Barcode",
                         onTap: () => gotoPage(context, "/barcodeScanner", repNamed: false)
                     ),
                     sideBarLinks(
                         context,
                         icon: "addNew.svg",
                         title: "Create New Offer",
                         onTap: () => gotoPage(context, "/newOffer", repNamed: false)
                     ),
                     SizedBox(height: getHeight(context)/20,),
                   ],
                 ),
                  sideBarLinks(
                      context,
                      icon: "setting.svg",
                      title: "Settings",
                      onTap: () => gotoPage(context, "/settingsMain")
                  ),
                ],
              ),
            ),
            PositionedTransition(
              child: ScaleTransition(
                  scale: tween2.animate(_animation),
                  alignment: Alignment.centerRight,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(isOpen ? getSize(context, 20) : 0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: colors.whiteBlue.withOpacity(0.37)
                      ),
                    ),
                  )
              ),
              rect: relativeRectTween2.animate(_controller),
            ),
            PositionedTransition(
              child: ScaleTransition(
                  scale: tween.animate(_animation),
                  alignment: Alignment.centerRight,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(isOpen ? getSize(context, 20) : 0),
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details){
                        if(details.delta.dx < getSize(context, 20)){
                          if(isOpen){
                            goBack();
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: isOpen ?
                        AbsorbPointer(child: widget._child(openSideBar),) :
                        widget._child(openSideBar)
                      ),
                    ),
                  )
              ),
              rect: relativeRectTween.animate(_controller),
            ),
            GestureDetector(
              onHorizontalDragUpdate: (details){
                if(details.delta.dx > 0){
                  openSideBar();
                }
              },
              child: Container(
                width: getSize(context, 30),
                color: Colors.transparent,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget bgSideBar(){
  return Container(
    color: colors.blueColor,
  );
}