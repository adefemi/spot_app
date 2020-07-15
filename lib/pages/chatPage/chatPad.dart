import 'package:flutter/material.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/chatCard.dart';
import 'package:spot_app/components/chatContent.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';


class ChatPad extends StatefulWidget {
  @override
  _ChatPadState createState() => _ChatPadState();
}

class _ChatPadState extends State<ChatPad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            bgColorLayer(),
            Container(
              child: SizedBox.expand(
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context)/15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(getSize(context, 50)),
                            bottomRight: Radius.circular(getSize(context, 50)),
                          )
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Icon(Icons.chevron_left, size: 35, color: Colors.black.withOpacity(0.6),),
                                ),
                                chatCard(context, "Ajoke 0.", "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg",
                                    message: "Available", type2: true, radius: 50, extra: Row(
                                      children: <Widget>[
                                        SizedBox(width: getSize(context, 10),),
                                        circle(5, color: colors.greenColor)
                                      ],
                                    ))
                              ],

                            ),
                            Icon(Icons.more_horiz, size: 30, color: Colors.black.withOpacity(0.6),)
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              chatContent(context, message: "Hi, I'd like to buy this Shoe", time: "9:34am"),
                              chatContent(context, message: "Hello, the price is 20k, No jale", time: "9:35am", owned: false),
                              chatContent(context, message: "Hi, I'd like to buy this Shoe", time: "9:34am"),
                              chatContent(context, message: "Hello, the price is 20k, No jale", time: "9:35am", owned: false),
                              chatContent(context, message: "Hi, I'd like to buy this Shoe", time: "9:34am"),
                              chatContent(context, message: "Hello, the price is 20k, No jale", time: "9:35am", owned: false),
                              chatContent(context, message: "Hi, I'd like to buy this Shoe", time: "9:34am"),
                              chatContent(context, message: "Hello, the price is 20k, No jale", time: "9:35am", owned: false),
                              chatContent(context, message: "Hi, I'd like to buy this Shoe", time: "9:34am"),
                              chatContent(context, message: "Hello, the price is 20k, No jale", time: "9:35am", owned: false),
                              chatContent(context, message: "Hi, I'd like to buy this Shoe", time: "9:34am"),
                              chatContent(context, message: "Hello, the price is 20k, No jale", time: "9:35am", owned: false),
                              SizedBox(height: getSize(context, 150),)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context)/15),
                height: getSize(context, 100),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: getSize(context, 70),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(getSize(context, 70)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10)
                          )
                        ]
                      ),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Container(
                              height: getSize(context, 50),
                              width: getSize(context, 50),
                              margin: EdgeInsets.only(left: getSize(context, 10), right: getSize(context, 10)),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(getSize(context, 60)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.05),
                                        offset: Offset(0, 10)
                                    )
                                  ]
                              ),
                              child: Transform.rotate(angle:(45*3.142/180), child: Icon(Icons.attach_file, color: Colors.black.withOpacity(0.3),)),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 3,
                            child: textInputField(context, onChange: (val){}, placeholder: "Type message here...", height: getSize(context, 60)),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Container(
                              child: Center(
                                child: Transform.rotate(angle:(-45*3.142/180), child: Icon(Icons.send, color: colors.pinkColor,),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
