import 'package:flutter/material.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/offerCard.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
//import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';


class BarcodeScannerMain extends StatefulWidget {
  @override
  _BarcodeScannerMainState createState() => _BarcodeScannerMainState();
}

class _BarcodeScannerMainState extends State<BarcodeScannerMain> {
  bool canShow = false;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";

  _onQRViewCreated(QRViewController con) {
    con.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    scanCode();
    Future.delayed(Duration(milliseconds: 1000), (){
      setState(() {
        canShow = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.blueColor.withOpacity(0.2),
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(context)/15),
          child: headingRole2(context, "Scan Barcode", fontSize: 15, colorMain:Colors.white, canGoBack: true, solid: true),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: canShow ? SizedBox() : Stack(
        children: <Widget>[
          Positioned(
            left: getWidth(context)/10,
            bottom: getSize(context, 20),
            child: FloatingActionButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              backgroundColor: Colors.white,
              child: Icon(Icons.close, color: colors.pinkColor,),
              elevation: 2,
            ),
          ),
          Positioned(
            left: getWidth(context)/10 + getSize(context, 80),
            bottom: getSize(context, 20),
            child: FloatingActionButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              backgroundColor: Colors.white,
              child: Icon(Icons.refresh, color: Colors.grey,),
              elevation: 2,
            ),
          ),
        ],
      ),
      body: Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: canShow ? QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ) : SizedBox(),
                flex: 1,
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: colors.blueColor.withOpacity(0.2),
          child: Column(
            children: <Widget>[
              SizedBox(height: getSize(context, 20),),
              textControl("Align the QR Code within", context, color: Colors.white, fontWeight: FontWeight.w600, font: fonts.proxima, size: 15),
              textControl("the frame", context, color: Colors.white, fontWeight: FontWeight.w600, font: fonts.proxima, size: 15),
              SizedBox(height: getHeight(context)/1.8),
              canShow ? textControl("Scanning Complete", context, color: Colors.white, font: fonts.proxima, size: 13) : SizedBox()
            ],
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          bottom: 10,
          right: canShow ? 0 : -getWidth(context),
          left: canShow ? 0 : getWidth(context),
          curve: Curves.easeIn,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context)/15),
            child: offerCard(context, date: "12-06-19", title: "Pink Nike Air Max",
                image: "https://cdn.pixabay.com/photo/2018/09/30/21/28/sneakers-3714729__340.jpg"),
          ),
        )
      ],
      ),
    );
  }
}
