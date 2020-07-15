import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_app/components/sideBarLayer.dart';
import 'package:spot_app/components/sideBarLayer2.dart';
import 'package:spot_app/pages/chatPage/chatPad.dart';
import 'package:spot_app/pages/chatPage/chatSearch.dart';
import 'package:spot_app/pages/homePage/splash.dart';
import 'package:spot_app/pages/offerPage/explore.dart';
import 'package:spot_app/pages/offerPage/newOffer.dart';
import 'package:spot_app/pages/offerPage/offerDeals.dart';
import 'package:spot_app/pages/offerPage/productView.dart';
import 'package:spot_app/pages/offerPage/searchOffer.dart';
import 'package:spot_app/pages/offerPage/singleOfferDeal.dart';
import 'package:spot_app/pages/offerPage/visiting.dart';
import 'package:spot_app/pages/selectRole/aboutCompany.dart';
import 'package:spot_app/pages/selectRole/aboutUser.dart';
import 'package:spot_app/pages/selectRole/companyCategory.dart';
import 'package:spot_app/pages/selectRole/otpSetup.dart';
import 'package:spot_app/pages/selectRole/phoneSetup.dart';
import 'package:spot_app/pages/selectRole/selectRole.dart';
import 'package:spot_app/pages/settingsPage/companyProfile.dart';
import 'package:spot_app/pages/settingsPage/settingsMain.dart';
import 'package:spot_app/pages/settingsPage/settingsTenant.dart';
import 'package:spot_app/pages/settingsPage/tenantProfile.dart';
import 'package:spot_app/pages/settingsPage/userInterests.dart';
import 'package:spot_app/pages/storePage/barcode.dart';
import 'package:spot_app/pages/storePage/barcodeScanner.dart';
import 'package:spot_app/pages/storePage/dashboardMain.dart';
import 'package:spot_app/pages/storePage/dashboardMain2.dart';
import 'package:spot_app/pages/storePage/payment.dart';
import 'package:spot_app/provider/systemMount.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';

void main(){
  SystemMount systemMount = SystemMount();
  systemMount.getRoles();
  return runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserOnBoardChangeNotifierModel>(create: (context) => UserOnBoardChangeNotifierModel()),
          ChangeNotifierProvider<SystemMount>(create: (context) => systemMount),
        ],
        child: MyApp(),
      )
  );
}

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
        "/searchOffer": (context) => SideBarControl2((Function showSideBar) => SearchOffer(showSideBar)),
        "/chatPad": (context) => ChatPad(),
        "/chatSearch": (context) => ChatSearch(),
        "/newOffer": (context) => SideBarControl((Function showSideBar) => NewOffer(showSideBar)),
        "/offerDeal": (context) => SideBarControl((Function showSideBar) => OfferDeal(showSideBar)),
        "/singleOfferDeal": (context) => SideBarControl((Function showSideBar) => SingleOfferDeal(showSideBar)),
        "/productView": (context) => SideBarControl((Function showSideBar) => ProductView(showSideBar)),
        "/visiting": (context) => SideBarControl((Function showSideBar) => VisitingSpotter(showSideBar)),
        "/dashboard": (context) => SideBarControl2((Function showSideBar) => Dashboard2(showSideBar)),
        "/dashboard2": (context) => SideBarControl((Function showSideBar) => Dashboard(showSideBar)),
        "/explore": (context) => SideBarControl2((Function showSideBar) => Explore(showSideBar)),
        "/payment": (context) => SideBarControl2((Function showSideBar) => PaymentMain(showSideBar)),
        "/barcode": (context) => Barcode(),
        "/barcodeScanner": (context) => BarcodeScannerMain(),
        "/settingsMain": (context) => SettingsMain(),
        "/settingsTenant": (context) => SettingsTenant(),
        "/companyProfile": (context) => CompanyProfile(),
        "/tenantProfile": (context) => TenantProfile(),
        "/userInterest": (context) => UserInterest(),
      },
    );
  }
}
