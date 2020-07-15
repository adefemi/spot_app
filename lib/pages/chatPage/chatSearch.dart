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

class ChatSearch extends StatefulWidget {

  @override
  _ChatSearchState createState() => _ChatSearchState();
}

class _ChatSearchState extends State<ChatSearch> {
  openChat(int chatId){
    Navigator.of(context).pushNamed("/chatPad");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            bgColorLayer(),
           Container(
             padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
             child: SingleChildScrollView(
               child:  Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[

                   SizedBox(height: getSize(context, 100),),
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
           ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: getWidth(context)/15, right: getWidth(context)/15, top: getSize(context, 20)),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.chevron_left, color: Colors.black.withOpacity(0.6), size: 30,),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: textInputField(context, placeholder: "Search", onChange: (val){}, height: 60),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
