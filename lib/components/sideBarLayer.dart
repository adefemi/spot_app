import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              bottom: -150,
              right: 10,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(-60 * 3.142/180),
                child: Transform.scale(scale: 1.5,
                  child: threeDots(context, color: Colors.white.withOpacity(0.05)),),),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 10
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50,),
                  headingRole(context, isSideBar: true, goBack: goBack),
                  SizedBox(height: 50,),
                  textControl("Hassan Stores", size: 20, fontWeight: FontWeight.w600, color: Colors.white),
                  SizedBox(height: 70,),
                  sideBarLinks(
                      context,
                      icon: "store.svg",
                      title: "My Dashboard"
                  ),
                  sideBarLinks(
                      context,
                      icon: "cart.svg",
                      title: "My Offers"
                  ),
                  sideBarLinks(
                      context,
                      icon: "user.svg",
                      title: "Visiting Spotters"
                  ),
                  sideBarLinks(
                      context,
                      icon: "chat.svg",
                      title: "Chats"
                  ),
                  sideBarLinks(
                      context,
                      icon: "barcode.svg",
                      title: "Scan Barcode"
                  ),
                  sideBarLinks(
                      context,
                      icon: "addNew.svg",
                      title: "Create New Offer"
                  ),
                  SizedBox(height: 50,),
                  sideBarLinks(
                      context,
                      icon: "setting.svg",
                      title: "Settings"
                  ),
                ],
              ),
            ),
            PositionedTransition(
              child: ScaleTransition(
                  scale: tween2.animate(_animation),
                  alignment: Alignment.centerRight,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(isOpen ? 20 : 0),
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
                    borderRadius: BorderRadius.circular(isOpen ? 20 : 0),
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details){
                        if(details.delta.dx < 20){
                          if(isOpen){
                            goBack();
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: widget._child(openSideBar)
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
                width: 10,
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

Widget sideBarLinks(BuildContext context, {String title: "", String icon: ""}){
  return Container(
    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 17),
    child: Row(
      children: <Widget>[
        SvgPicture.asset("assets/svgs/$icon", color: Colors.white,),
        SizedBox(width: 20,),
        textControl(title, size: 16, fontWeight: FontWeight.w500, color: Colors.white)
      ],
    ),
  );
}