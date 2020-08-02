import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:spot_app/components/alertViewer.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/formGroup.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/loader.dart';
import 'package:spot_app/components/offerCard.dart';
import 'package:spot_app/components/paymentCard.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/components/webViewSample.dart';
import 'package:spot_app/network/customRequestHandler.dart';
import 'package:spot_app/network/data.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentMain extends StatefulWidget {
  final Function showSideBar;
  PaymentMain(this.showSideBar);

  @override
  _PaymentMainState createState() => _PaymentMainState();
}

class _PaymentMainState extends State<PaymentMain> {
  bool fetching = true;
  bool canClose = false;
  bool fetchingBanks = true;
  int quantity = 1;
  Map<String, dynamic> activeDeal = {};
  List<dynamic> bankCards = [];
  bool status = false;
  bool loading = false;
  bool loadingMain = false;
  bool disabled = true;
  int payState = 1;
  int activeCardId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1), (){
      Map args = ModalRoute.of(context).settings.arguments;
      if(args != null){
        getActiveDeals(args["id"]);
        if(args["cont"] != null){
          finishPayment(cont: true, referenceMain: args["otherData"]["reference"]);
        }
      }
      getBanks();
    });

  }

  getActiveDeals(String id) async {
    List<dynamic> _deals = await fetchDeals(context, extra: "?id=$id");
    setState(() {
      activeDeal = _deals[0];
      fetching = false;
    });
  }

  getBanks() async {
    dynamic _banks = await fetchPaymentCard(context);
    setState(() {
      bankCards = _banks["data"];
      fetchingBanks = false;
      disabled = _banks["data"].length > 0 ? false : true;
    });
  }

  Map<String, dynamic> getChargeData(){
    double dealAmount = double.parse(activeDeal["amount"].toString()) * 100;
    UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
    return {
      "amount": dealAmount * quantity,
      "clientId": networkData.getClientId(),
      "productId": activeDeal["productId"],
      "userId": userOnBoardChangeNotifierModel.userData["userId"],
      "discount": 0
    };
  }

  finishPayment({bool cont: false, String referenceMain}) async{
    String ref;
    if(!cont){
      if(quantity == null){
        Fluttertoast.showToast(msg: "Specify quantity to continue");
        return;
      }
      setState(() {
        status = true;
        payState = 1;
      });
      Map<String, dynamic> activeBank = bankCards[activeCardId];

      // charge user wallet if their is enough money
      ref = await chargeWallet(context, getChargeData(), showError: false);

      // fund wallet if not enough money
      if(ref == ""){
        bool statusData = await fundWallet(context, activeBank["authorization"], getChargeData()["amount"]);
        if(statusData){
          ref = await chargeWallet(context, getChargeData());
          if(ref == ""){
            setState(() {
              status = false;
            });
            return;
          }
        }
        else{
          setState(() {
            status = false;
          });
          return;
        }
      }
    }
    else{
      setState(() {
        payState = 1;
        status = true;
      });
      // verify payment
      bool stat = await verifyPaymentMain(context, referenceMain);
      if(!stat){
        setState(() {
          status = false;
        });
        return;
      }
      await Future.delayed(Duration(seconds: 5));

      // charge user wallet if their is enough money
      ref = await chargeWallet(context, getChargeData(), showError: false);
    }
    // pin deal
    bool stateData = await pinDeal(context, quantity, activeDeal["productId"], ref);
    if(stateData){
      setState(() {
        payState = 2;
      });
    }
    else{
      setState(() {
        status = false;
      });
    }
  }

  initiatePayment() async {
    if(quantity == null){
      Fluttertoast.showToast(msg: "Specify quantity to continue");
      return;
    }
    setState(() {
      loadingMain = true;
    });
    double dealAmount = double.parse(activeDeal["amount"].toString()) * 100;
    String ref = "spot_"+getRandomString(10);
    dynamic res = await initializePaymentMain(context, dealAmount * quantity, ref);
    if(res["url"] != null && res["url"] != ""){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WebViewExample(res["url"], "/payment", activeDeal["id"], {"quantity":quantity, "reference": ref})));
    }
    else{
      setState(() {
        loadingMain = false;
      });
    }
  }

  List<Widget> getCards(){
    List<Widget> tempHolder = [];
    for(int i =0; i<bankCards.length; i++){
      tempHolder.add(
          paymentCard(context, isFirst: i == 0, isActive: i == activeCardId, cardNum: "**${bankCards[i]['last4']}", cardType: "${bankCards[i]['cardType']}".toUpperCase(), onTap: (){
            setState(() {
              activeCardId = i;
            });
          })
      );
    }
    return tempHolder;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(context)/12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      textControl("Choose your payment method", context, size: 18, fontWeight: FontWeight.w600, color: colors.blueColor3),
                      SizedBox(height: getSize(context, 15),),
                      fetching ? offerLoader(context) : offerCard(context, title: activeDeal["title"], image: activeDeal["images"][0]),
                      fetching ? SizedBox() : formGroup(context,
                          textInputField(context, value: quantity.toString(), height: 60, type: "number", onChange: (e){
                            setState(() {
                              quantity = int.parse(e);
                            });
                          }, range: true, min: 1, max: int.parse(activeDeal["availableQuantity"].toString())),
                          label: "Quantity"),
                      SizedBox(height: getSize(context, fetching ? 15 : 0),),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: getSize(context, 10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            textControl("Saved Cards", context, size: 15, color: colors.blueColor3, fontWeight: FontWeight.w600),
                            Row(
                              children: <Widget>[
                                fetchingBanks ? simpleLoader(context, width: 100, height: 20) :
                                GestureDetector(
                                  child: textControl("Add card", context, size: 15, color: colors.blueColor3, fontWeight: FontWeight.w500),
                                  onTap:initiatePayment,
                                ),
                                Icon(Icons.add, size: getSize(context, 15), color: colors.blueColor3)
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: getSize(context, 5),),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: getSize(context, 20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(),
                            Row(
                              children: <Widget>[
                                circle(getSize(context, 5), color: colors.pinkColor),
                                SizedBox(width: getSize(context, 7),),
                                circle(getSize(context, 5), color:colors.pinkColor.withOpacity(0.28)),
                                SizedBox(width: getSize(context, 7),),
                                circle(getSize(context, 5), color: colors.pinkColor.withOpacity(0.28)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getSize(context, 10),),
                fetchingBanks ? simpleLoader(context, width: getWidth(context), height: 290) :
                    bankCards.length < 1 ? Container(
                      height: getSize(context, 200),
                      margin: EdgeInsets.symmetric(horizontal: getWidth(context)/12),
                      color: Colors.white,
                      child: Center(
                        child: textControl("No card available", context),
                      ),
                    ) :
                Container(
                  height: getSize(context, 290),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: getCards(),
                  ),
                ),
                SizedBox(height: getSize(context, 20),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          textControl("TOTAL", context, color: colors.deepPink, size: 11,fontWeight: FontWeight.bold, spacing: 5),
                          fetching ? simpleLoader(context, width: 100, height: 20) :
                          textControl("N${activeDeal['amount']}", context, color: colors.blueColor.withOpacity(0.8), size: 18,fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(height: getSize(context, 20),),
                      Hero(
                        tag: "makePayment",
                        child: Material(
                          type: MaterialType.transparency,
                          child: simpleButton("Finish", context, padH: double.infinity, disabled: disabled, onTap: finishPayment),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: getSize(context, 20),),
              ],
            ),
          ),
        ),
        alertViewer(context, status: status, canClose: canClose, closeAlert: (){
          setState(() {
            status = false;
          });
        }, child: payState == 1 ? Container(
          height: getSize(context, 150),
          child: Center(
            child: SpinKitChasingDots(
              size: getSize(context, 50),
              color: colors.blueColor,
            ),
          ),
        ) : paymentConfirmation(context)),
        loaderMain(context, status: loadingMain)
      ],
    );
  }
}

Widget paymentConfirmation(BuildContext context){
  return Column(
    children: <Widget>[
      textControl("Payment successful", context, size: 17, fontWeight: FontWeight.w500, color: colors.blueColor3.withOpacity(0.9)),
      SizedBox(height: getSize(context, 15),),
      insertContent(context, height: 120, width: 120, borderRadius: 120, color: colors.greenColor2.withOpacity(0.3),
          child: insertContent(context, height: 70, width: 70, borderRadius: 70, color: colors.greenColor2,
              child: Icon(Icons.check, color: Colors.white, size: getSize(context, 40),)),),
      SizedBox(height: getSize(context, 30),),
      simpleButton("See your pinned Item", context, padH: double.infinity, onTap: (){
        Navigator.of(context).pushReplacementNamed('/explore');
      },
          color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w500, padV: 70, borderRadius: 70),
      SizedBox(height: getSize(context, 20),),
    ],
  );
}
