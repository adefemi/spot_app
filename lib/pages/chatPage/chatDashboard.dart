import 'package:flutter/material.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/chatCard.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/recentChatCard.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class ChatDashboard extends StatefulWidget {
  const ChatDashboard(this.showSideBar);
  final Function showSideBar;

  @override
  _ChatDashboardState createState() => _ChatDashboardState();
}

class _ChatDashboardState extends State<ChatDashboard> {
  FocusNode searchNode = FocusNode();

  openChat(int chatId){
    Navigator.of(context).pushNamed("/chatPad");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchNode.addListener((){

      if(searchNode.hasFocus){
        FocusScope.of(context).unfocus();
        Navigator.of(context).pushNamed("/chatSearch");
      }
    });
  }

  @override
  void dispose() {
    searchNode.dispose();
    super.dispose();
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
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context)/15),
                child: headingRole2(context, "Chats", togNav: widget.showSideBar, colorMain: colors.blueColor),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(getSize(context, 40))),
                    child: Container(
                      width: getWidth(context),
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: getSize(context, 20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                textControl("Pink Nike Air Max", context, size: 18, color: colors.blueColor.withOpacity(0.9), fontWeight: FontWeight.w600),
                                simpleButton("View Product", context, padH: 120, padV: 40, fontSize: 13, color: Colors.black.withOpacity(0.5), backColor: colors.blueLight2.withOpacity(0.66)),
                              ],
                            ),
                          ),
                          SizedBox(height: getSize(context, 20),),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
                            child: Row(
                              children: <Widget>[
                                textControl("All Chats", context, size: 18, fontWeight: FontWeight.w600),
                                SizedBox(width: 5,),
                                textControl("| 10", context, size: 18),
                              ],
                            ),
                          ),
                          SizedBox(height: getSize(context, 5),),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
                              child: circle(getSize(context, 8), color: colors.pinkColor)),
                          SizedBox(height: getSize(context, 15),),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
                              child: textControl("Recent Chats", context, size: 15, color: colors.blueColor3.withOpacity(0.5))),
                          SizedBox(height: getSize(context, 20),),
                          Container(
                            height: getSize(context, 90),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                recentChatCard(context, "Ajoke. O", "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", isFirst: true,  onTap: () => openChat(1)),
                                recentChatCard(context, "Hassan. R", "https://cdn.pixabay.com/photo/2017/12/22/14/42/girl-3033718__340.jpg",  onTap: () => openChat(1)),
                                recentChatCard(context, "Kemi. A", "https://cdn.pixabay.com/photo/2016/11/22/06/05/girl-1848454__340.jpg",  onTap: () => openChat(1)),
                                recentChatCard(context, "Julius. O", "https://cdn.pixabay.com/photo/2018/08/04/20/48/woman-3584435__340.jpg",  onTap: () => openChat(1)),
                                recentChatCard(context, "Bola. O", "https://cdn.pixabay.com/photo/2018/03/06/22/57/portrait-3204843__340.jpg",  onTap: () => openChat(1)),
                                recentChatCard(context, "Babs. A", "https://cdn.pixabay.com/photo/2018/03/12/12/32/woman-3219507__340.jpg",  onTap: () => openChat(1)),
                                recentChatCard(context, "Tosin. B", "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg",  onTap: () => openChat(1)),
                                recentChatCard(context, "Victor. F", "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg",  onTap: () => openChat(1)),
                                recentChatCard(context, "Grace. A", "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg",  onTap: () => openChat(1)),
                                recentChatCard(context, "Miles. O", "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg",  onTap: () => openChat(1)),
                                recentChatCard(context, "Festus. O", "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg",  onTap: () => openChat(1)),
                                recentChatCard(context, "Gloria. O", "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", isLast: true,  onTap: () => openChat(1)),
                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: getSize(context, 30),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
                    child: Column(
                      children: <Widget>[
                        chatCard(context, "Ajoke 0.", "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg",
                            message: "Where are u going", count: "10", onTap: () => openChat(1)),
                        chatCard(context, "Kemi 0.", "https://cdn.pixabay.com/photo/2017/12/22/14/42/girl-3033718__340.jpg", count: "6", onTap: () => openChat(1)),
                        chatCard(context, "Julius 0.", "https://cdn.pixabay.com/photo/2016/11/22/06/05/girl-1848454__340.jpg", message: "Where are u going", count: "1", onTap: () => openChat(1)),
                        chatCard(context, "Hassan 0.", "https://cdn.pixabay.com/photo/2018/08/04/20/48/woman-3584435__340.jpg", message: "Where are u going", count: "3", onTap: () => openChat(1)),
                        chatCard(context, "Bola 0.", "https://cdn.pixabay.com/photo/2018/03/06/22/57/portrait-3204843__340.jpg", message: "Where are u going", count: "5", onTap: () => openChat(1)),
                        chatCard(context, "Gloria 0.", "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", message: "Where are u going", onTap: () => openChat(1)),
                        chatCard(context, "Festus 0.", "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", message: "Where are u going", onTap: () => openChat(1)),
                        chatCard(context, "Ajoke 0.", "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", message: "Where are u going", onTap: () => openChat(1)),
                        chatCard(context, "Ajoke 0.", "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", message: "Where are u going", onTap: () => openChat(1)),
                        chatCard(context, "Ajoke 0.", "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", message: "Where are u going", onTap: () => openChat(1)),
                        chatCard(context, "Ajoke 0.", "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", message: "Where are u going", onTap: () => openChat(1)),
                      ],
                    ),
                  ),
                  SizedBox(height: getSize(context, 70),),
                ],
              ),
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
              height: 160,
              child: Column(
                children: <Widget>[
                  textInputField(context, height: 60, placeholder: "Search", focusNode: searchNode),
                  SizedBox(height: getSize(context, 100),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
