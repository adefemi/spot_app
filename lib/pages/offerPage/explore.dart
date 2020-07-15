import 'package:flutter/material.dart';
import 'package:spot_app/components/alertViewer.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/exploreCard.dart';
import 'package:spot_app/components/exploreView.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/offerCard.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

class Explore extends StatefulWidget {
  const Explore(this.showSideBar);
  final Function showSideBar;

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> with TickerProviderStateMixin {

  bool status = false;
  String activeImage = "";

  gotoDeal({int id: 0}){
    Navigator.of(context).pushNamed("/productView");
  }

  setActiveProduct(e){
    setState(() {
      activeImage = e;
      status = true;
    });
  }

  goChat(){
    Navigator.of(context).pushNamed("/chatPad");
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
                    child: headingRole2(context, "Explore", fontSize: 15, togNav: widget.showSideBar, colorMain: colors.blueColor, canGoBack: true, solid: true),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                body: ExploreView(
                  [
                    exploreCard(context, image: "https://pngimg.com/uploads/running_shoes/running_shoes_PNG5827.png", onChat: goChat, onView: gotoDeal,
                        name: "Nike  Max", price: "N20,000", onPin: (e) => setActiveProduct("https://pngimg.com/uploads/running_shoes/running_shoes_PNG5827.png")),
                    exploreCard(context, image: "https://www.searchpng.com/wp-content/uploads/2019/01/Nike-Shoe-PNG-715x715.png", onChat: goChat, onView: gotoDeal,
                        name: "Nike Air Max", price: "N25,000", onPin: (e) => setActiveProduct("https://www.searchpng.com/wp-content/uploads/2019/01/Nike-Shoe-PNG-715x715.png")),
                    exploreCard(context, image: "https://www.pngmart.com/files/1/Nike-Shoes-Transparent-Background.png", onChat: goChat, onView: gotoDeal,
                        name: "Nike Air Max", price: "N29,000", onPin: (e) => setActiveProduct("https://www.pngmart.com/files/1/Nike-Shoes-Transparent-Background.png")),
                    exploreCard(context, image: "https://www.pngitem.com/pimgs/m/194-1944024_transparent-gym-shoes-png-popular-80s-shoes-men.png", onChat: goChat, onView: gotoDeal,
                        name: "Adidas Gym Max", price: "N22,000", onPin: (e) => setActiveProduct("https://www.pngitem.com/pimgs/m/194-1944024_transparent-gym-shoes-png-popular-80s-shoes-men.png")),
                    exploreCard(context, image: "https://www.transparentpng.com/thumb/adidas-shoes/a4xO3G-adidas-shoes-adidas-shoe-kids-superstar-daddy-grade.png",  onChat: goChat, onView: gotoDeal,
                        name: "Adidas Max", price: "N28,000", onPin: (e) => setActiveProduct(e)),
                    exploreCard(context, image: "https://www.pngitem.com/pimgs/m/114-1149906_sneakers-skate-shoe-nike-one-transparent-background-png.png",  onChat: goChat, onView: gotoDeal,
                        name: "Nike Sneakers", price: "N30,000", onPin: (e) => setActiveProduct(e)),
                    exploreCard(context, image: "https://www.alisuperprice.com/wp-content/uploads/revslider/home-v10-slider/shoe.png", onChat: goChat, onView: gotoDeal,
                        name: "RevSlider Max", price: "N23,000", onPin: (e) => setActiveProduct(e)),
                    exploreCard(context, image: "https://www.freeiconspng.com/uploads/running-shoes-images-download-29.png", onChat: goChat, onView: gotoDeal,
                        name: "Nike Air Max", price: "N48,000", onPin: (e) => setActiveProduct(e)),
                  ],
                  context
                )
            ),
            alertViewer(context, status: status, closeAlert: (){
              setState(() {
                status = false;
              });
            }, child: productConfirmation(context, image: activeImage))
          ],
        ),
      ),
    );
  }
}

Widget productConfirmation(BuildContext context, {String image: ""}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      textControl("Summary", context, fontWeight: FontWeight.w600, size: 17, color: colors.blueColor3),
      SizedBox(height: getSize(context, 20),),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          insertContent(context, width: 100, height:35, borderRadius: 35,
              child: textControl("Sport", context,color: Colors.white, size: 13, fontWeight: FontWeight.w500, font: fonts.proxima)),
          textControl("Listed 21 Mar", context, size: 13, color: Colors.black.withOpacity(0.3), font: fonts.proxima, fontWeight: FontWeight.w500),
        ],
      ),
      SizedBox(height: getSize(context, 20),),
      offerCard(context, title: "Pink Nike Air Max", image: image),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          textControl("TOTAL", context, color: colors.deepPink.withOpacity(0.6), size: 11,fontWeight: FontWeight.bold, spacing: 5),
          textControl("N10,000", context, color: colors.blueColor.withOpacity(0.8), size: 18,fontWeight: FontWeight.bold),
        ],
      ),
      SizedBox(height: getSize(context, 20),),
      Hero(
        tag: "makePayment",
        child: Material(
          type: MaterialType.transparency,
          child: simpleButton("Make Payment",
              context, color: Colors.white.withOpacity(0.9), onTap: (){
                Navigator.of(context).pushNamed("/payment");
              },
              padH: double.infinity),
        ),
      ),
      SizedBox(height: getSize(context, 20),),
    ],
  );
}
