import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/fileSelector.dart';
import 'package:spot_app/components/formGroup.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/progressStep.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class NewOffer extends StatefulWidget {
  const NewOffer(this.showSideBar);
  final Function showSideBar;

  @override
  _NewOfferState createState() => _NewOfferState();
}

class _NewOfferState extends State<NewOffer> {
  int activeStage = 1;

  onProgress(){
    setState(() {
      activeStage = activeStage+1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        bgColorLayer(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox.expand(
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 3,
                  child: Container(
                    child:  Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: colors.blueColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(getSize(context, 80)))
                          ),
                        ),
                        Positioned(
                          right: -getSize(context, getWidth(context) / 10),
                          top: getSize(context, 0),
                          child: Transform(
                            transform: Matrix4.rotationZ(
                                -getSize(context, 20) * 3.142 / 180
                            ),
                            child: Transform.scale(scale: getSize(context, 1.2),
                              child: threeDots(
                                  context, color: Colors.white.withOpacity(0.05)),),
                          ),
                        ),
                        Container(
                          width: getSize(context, getWidth(context) / 2),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.008),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(getSize(context, 80)))
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: getSize(context, getWidth(context) / 10),
                              vertical: getSize(context, 0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              headingRole2(context, "Create a Deal", togNav: widget.showSideBar, solid: true, canGoBack: true, fontSize: 15),
                              Column(
                                children: <Widget>[
                                  textControl(
                                      "New Offer", context, size: getSize(context, 25),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                  SizedBox(height: getSize(context, 15),),
                                  circle(getSize(context, 10), color: colors.pinkColor),
                                  SizedBox(height: getSize(context, 25),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      progressStep(context, active: activeStage == 1 ? true : false),
                                      progressStep(context, active: activeStage == 2 ? true : false),
                                      progressStep(context, isLast: true, active: activeStage == 3 ? true : false),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 7,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidth(context) / 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: getSize(context, 30),),
                          textControl(
                              activeStage == 3 ? "Upload images" : "Tell us about it", context, fontWeight: FontWeight.w600, color: colors.blueColor3),
                          SizedBox(height: getSize(context, activeStage == 3 ? 0 : 30),),
                          activeStage == 1 ? stage1(context) : activeStage == 2 ? stage2(context) : stage3(context),
                          SizedBox(height: getSize(context, activeStage == 1 ? 30 : 20),),
                          Center(
                            child: simpleButton(activeStage == 2 ? "Upload Images" : "Create deal",
                                context, padH: getSize(context, activeStage == 1 ? 130 : 200),
                                color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w400, fontSize: 15,
                                child: activeStage == 1 ? Icon(Icons.chevron_right, size: getSize(context, 25), color: Colors.white,) : null,
                              onTap: onProgress
                            ),
                          ),
                          SizedBox(height: getSize(context, 50),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
        )
      ],
    );
  }
}

Widget stage1(BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      formGroup(context, textInputField(context, placeholder: "", height: 67), label: "Title"),
      formGroup(context, textInputField(context, placeholder: "", height: 67), label: "Price"),
      formGroup(context, textInputField(context, placeholder: "", height: 100, multiLine: true), label: "Description",),
      formGroup(context, textInputField(context, placeholder: "", height: 67), label: "Quantity"),
    ],
  );
}
Widget stage2(BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      formGroup(context, inputSelectField(context, value: "2 hours", height: 67, itemList: ["1 hour", "2 hours"], onSelect: (value){}), label: "Maximum time to Claim"),
      formGroup(context, inputSelectField(context, value: "2nd March, 2019", height: 67, itemList: ["2nd March, 2019", "3rd March, 2019"], onSelect: (value){}), label: "Deadline"),
      formGroup(context, sliderWidget(context, value: 5, onSelect: (value){}), label: "Range in Kilometeres"),
    ],
  );
}
Widget stage3(BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: getSize(context, 15),),
      textControl("Maximum of 3 images, less than 500kb", context, size: 15, color: colors.blueColor.withOpacity(0.6)),
      SizedBox(height: getSize(context, 20),),
      fileSelector(context, height: 180, borderRadius: 50, child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset("assets/svgs/upload.svg", color: colors.pinkColor,),
          SizedBox(height: getSize(context, 10),),
          textControl("Add Image", context, size: 14, color: colors.blueColor.withOpacity(0.8))
        ],
      )),
      SizedBox(height: getSize(context, 30),),
    ],
  );
}
