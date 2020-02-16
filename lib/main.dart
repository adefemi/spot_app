import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_app/components/sideBarLayer.dart';
import 'package:spot_app/pages/homePage/splash.dart';
import 'package:spot_app/pages/offerPage/searchOffer.dart';
import 'package:spot_app/pages/selectRole/aboutCompany.dart';
import 'package:spot_app/pages/selectRole/aboutUser.dart';
import 'package:spot_app/pages/selectRole/companyCategory.dart';
import 'package:spot_app/pages/selectRole/otpSetup.dart';
import 'package:spot_app/pages/selectRole/phoneSetup.dart';
import 'package:spot_app/pages/selectRole/selectRole.dart';
import 'package:spot_app/pages/storePage/dashboard.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider<UserOnBoardChangeNotifierModel>(create: (context) => UserOnBoardChangeNotifierModel()),
    ],
    child: MyApp(),
  )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => Splash(),
        "/roleSelect": (context) => SelectRole(),
        "/phoneSetup": (context) => PhoneSetup(),
        "/otpSetup": (context) => OtpSetup(),
        "/aboutUser": (context) => AboutUser(),
        "/aboutCompany": (context) => AboutCompany(),
        "/companySelect": (context) => CompanyCategory(),
        "/searchOffer": (context) => SearchOffer()
      },
    );
  }
}
