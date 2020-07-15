import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/imageBanner.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/offerCard.dart';
import 'package:spot_app/components/offerClaimCard.dart';
import 'package:spot_app/components/offerTab.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

class SingleOfferDeal extends StatefulWidget {
  const SingleOfferDeal(this.showSideBar);
  final Function showSideBar;

  @override
  _SingleOfferDealState createState() => _SingleOfferDealState();
}

class _SingleOfferDealState extends State<SingleOfferDeal> {

  viewProduct(){
    Navigator.of(context).pushNamed("/productView");
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
                    child: headingRole2(context, "Offer Deal", togNav: widget.showSideBar, colorMain: colors.blueColor, canGoBack: true),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: getSize(context, 30),),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    insertContent(context, borderRadius: 10, child: SvgPicture.asset("assets/svgs/pin.svg", color: Colors.white,)),
                                    SizedBox(width: getSize(context, 10),),
                                    textControl("50 Pins", context, color: colors.blueColor.withOpacity(0.9), size: 20,fontWeight: FontWeight.w600),
                                  ],
                                ),
                                
                                Container(
                                  width: getSize(context, 100),
                                  child: offerTab(context, text: "Completed", active: true),
                                )
                              ],
                            ),
                            SizedBox(height: getSize(context, 20),),
                            imageBanner(context, borderRadius: getWidth(context)/7,
                                image: "https://cdn.pixabay.com/photo/2018/09/30/21/28/sneakers-3714729__340.jpg", width: getWidth(context), height: getSize(context, 300)),
                            SizedBox(height: getSize(context, 20),),
                            Container(
                              width: getSize(context, 120),
                              child: offerTab(context, text: "View Product", fontWeight: FontWeight.w600, onTap: viewProduct,
                                  defaultColor: colors.blueColor3.withOpacity(0.1), defaultTextColor: Colors.black.withOpacity(0.6)),
                            ),
                            SizedBox(height: getSize(context, 20),),
                            textControl("Pink Nike Air Max", context, color: colors.blueColor.withOpacity(0.9), size: 18,fontWeight: FontWeight.w600),
                            SizedBox(height: getSize(context, 30),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.favorite, color: colors.blueColor.withOpacity(0.4), size: 15,),
                                        SizedBox(width: getSize(context, 5),),
                                        textControl("200 likes", context, color: colors.blueColor.withOpacity(0.5), size: 14, font: fonts.proxima),
                                      ],
                                    ),
                                    SizedBox(width: getSize(context, 20),),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.close, color: colors.blueColor.withOpacity(0.4), size: 15,),
                                        SizedBox(width: getSize(context, 5),),
                                        textControl("10 dislikes", context, color: colors.blueColor.withOpacity(0.5), size: 14, font: fonts.proxima),
                                      ],
                                    ),
                                  ],
                                ),

                                insertContent(context, color: colors.blueColor3.withOpacity(0.1), width: getSize(context, 110), borderRadius: 10, child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.chat_bubble, color: colors.blueColor, size: 15,),
                                    SizedBox(width: getSize(context, 5),),
                                    textControl("Chats | 10", context, color: colors.blueColor, size: 14, font: fonts.proxima),
                                  ],
                                ),)
                              ],
                            ),
                            SizedBox(height: getSize(context, 30),),
                            textControl("Offer Claimed by", context, size: getSize(context, 20), fontWeight: FontWeight.w700, color: colors.blueColor3),
                            SizedBox(height: getSize(context, 20),),
                            offerClaimCard(context, image: "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", title: "Alice A", 
                                date: textControl("Claimed on 12-06-2019", context, size: 11, color: Colors.black.withOpacity(0.3))),
                            SizedBox(height: getSize(context, 20),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                textControl("Pinned By", context, size: getSize(context, 20), fontWeight: FontWeight.w700, color: colors.blueColor3),
                                Row(
                                  children: <Widget>[
                                    textControl("All", context, color: colors.pinkColor, size: 13,fontWeight: FontWeight.w600),
                                    Icon(Icons.keyboard_arrow_down, size: 12, color: colors.pinkColor,)
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: getSize(context, 20),),
                            offerClaimCard(context, image: "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", title: "Alice A",
                                date: textControl("Claimed on 12-06-2019", context, size: 11, color: Colors.black.withOpacity(0.3))),
                            offerClaimCard(context, image: "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", title: "Alice A",
                                date: textControl("Claimed on 12-06-2019", context, size: 11, color: Colors.black.withOpacity(0.3))),
                            offerClaimCard(context, image: "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", title: "Alice A",
                                date: textControl("Claimed on 12-06-2019", context, size: 11, color: Colors.black.withOpacity(0.3))),
                            offerClaimCard(context, image: "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", title: "Alice A",
                                date: textControl("Claimed on 12-06-2019", context, size: 11, color: Colors.black.withOpacity(0.3))),
                            offerClaimCard(context, image: "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", title: "Alice A",
                                date: textControl("Claimed on 12-06-2019", context, size: 11, color: Colors.black.withOpacity(0.3))),
                            offerClaimCard(context, image: "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", title: "Alice A",
                                date: textControl("Claimed on 12-06-2019", context, size: 11, color: Colors.black.withOpacity(0.3))),
                            offerClaimCard(context, image: "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-photography-657116__340.jpg", title: "Alice A",
                                date: textControl("Claimed on 12-06-2019", context, size: 11, color: Colors.black.withOpacity(0.3))),
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
