import 'package:flutter/material.dart';
import 'package:spot_app/components/sideBarLayer.dart';
import 'package:spot_app/pages/offerPage/searchOffer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => SideBarControl((Function showSideBar) => SearchOffer(showSideBar))
      },
    );
  }
}
