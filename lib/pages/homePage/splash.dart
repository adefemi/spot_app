import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/models/errorHandler.dart';
import 'package:spot_app/models/options.dart';
import 'package:spot_app/network/data.dart';
import 'package:spot_app/network/requestManage.dart';
import 'package:spot_app/pages/homePage/splashSub.dart';
import 'package:spot_app/provider/systemMount.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  PageController _pageController = PageController();
  bool start = false;
  bool canMove = false;
  bool showLoading = false;

  String verifyRole(String roleId){
    List roles = Provider.of<SystemMount>(context, listen: false).roles;
    if(roles != null){
      List filtered = roles.where((item) => item["id"] == roleId).toList();
      if(filtered[0]["name"].toString().toLowerCase() == spotRoles.spotter.toLowerCase()){
        return spotRoles.spotter;
      }
      else if(filtered[0]["name"].toString().toLowerCase() == spotRoles.merchant.toLowerCase()){
        return spotRoles.merchant;
      }
    }

    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startAnim();
    setUpData();
  }

  void setUpData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(spotPrefs.token);
    if(token != null){
      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() {
          showLoading = true;
        });
      });

      final header = networkData.setHeader(userBearer: true, token: token);
      HttpRequests httpRequests = HttpRequests(url: networkData.getMe(), headers: header);
      Response response = await httpRequests.get();
      ErrorHandler errorHandler = ErrorHandler(response: response);
      if(!errorHandler.hasError){
        printWrapped(token);
        Map body = json.decode(response.body) as Map;
        print(body["data"]);
        Map profileData = body["data"]["profile"];
        String roleId = body["data"]["roleId"];
        String role = verifyRole(roleId);
        if(role == null){
          Fluttertoast.showToast(msg: "User role not found...");
          setState(() {
            canMove = true;
          });
        }
        UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
        userOnBoardChangeNotifierModel.setToken(token);
        userOnBoardChangeNotifierModel.changeRole(role, roleId);
        Map<String, dynamic> userData = {};
        userData.addAll(profileData);
        userData["meta"] = null;
        userData.addAll(profileData["meta"]);
        userData.addAll(body["data"]);
        userOnBoardChangeNotifierModel.setUserData(userData);

        if(role == spotRoles.spotter){
          if(userData["name"] == null || userData["name"] == ""){
            Fluttertoast.showToast(msg: "You need to add up your name");
            Navigator.of(context).pushNamed("/aboutUser");
          }
          else if(userData["interests"] == null){
            Fluttertoast.showToast(msg: "Let us know what you're interested in...");
            Navigator.of(context).pushNamed("/userInterest");
          }
          else{
            Navigator.of(context).pushNamed("/searchOffer");
          }
        }
        else{
          if(userData["companyName"] == null){
            Navigator.of(context).pushNamed("/aboutCompany");
          }
          else if(userData["businessCategory"] == null){
            Navigator.of(context).pushNamed("/companySelect");
          }
          else{
            Navigator.of(context).pushNamed("/dashboard2");
          }

        }
      }
      else{
        Fluttertoast.showToast(msg: "You're logged out");
        Navigator.of(context).pushNamed("/roleSelect");
      }
    }
    else{
      setState(() {
        canMove = true;
      });
    }

    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void startAnim(){
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        start = true;
      });
    });
  }

  void moveNext(){
    Future.delayed(const Duration(milliseconds: 1200), () {
      _pageController.animateToPage(1,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn);

    });
  }
  @override

  Widget build(BuildContext context) {

    return PageView(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: SizedBox.expand(
            child: Consumer<SystemMount>(
              builder: (context, model, child){
                if(model.roles != null && canMove){
                  moveNext();
                }
                return Stack(
                  children: <Widget>[
                    SizedBox.expand(
                      child: AnimatedContainer(
                        color: start ? colors.blueColor : colors.pinkColor,
                        duration: Duration(milliseconds: 500),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: !start ? null : Text("Spot", style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: fonts.playFairItalic,
                                  fontSize: getSize(context, 40)
                              ),),
                            ),
                            showLoading ? SizedBox(height: getSize(context, 10),) : SizedBox(),
                            showLoading ? Center(
                              child: SpinKitRing(
                                color: Colors.white,
                                size: getSize(context, 20),
                                lineWidth: 2,
                              ),
                            ) : SizedBox()
                          ],
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      child: threeDots(context),
                      bottom: start ? 0 : getHeight(context) - 200,
                      right: start ? -30 : getWidth(context) / 8,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        SplashSub()
      ],
    );
  }
}

// from top: -50, to bottom: 20
// from right: MediaQuery.of(context).size.width / 8, to right: -30