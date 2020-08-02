import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/fileSelector.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/network/customRequestHandler.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spot_app/utils/helpers.dart';

class AboutCompany extends StatefulWidget {
  @override
  _AboutCompanyState createState() => _AboutCompanyState();
}

class _AboutCompanyState extends State<AboutCompany> {
  File _logo;
  String companyName;
  String companyLocation;
  bool loading = false;

  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _logo = image;
    });
  }

  void submit(Function callback) async {
    if(companyName == null || companyLocation == null || _logo == null){
      Fluttertoast.showToast(msg: "Fill all fields to proceed...", backgroundColor: Colors.red, textColor: Colors.white);
      return;
    }
    setState(() {
      loading = true;
    });
    var logoData = await uploadImage(_logo.path);
    if(logoData == "false")return;
    Map updateData = {
      "companyName": companyName,
      "companyLocation": companyLocation,
      "logo": logoData
    };
    updateUserData(updateData, setStateWithStatus, context, callback);
  }

  void setStateWithStatus(bool status){
    setState(() {
      loading = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child:  Stack(
          children: <Widget>[
            bgColorLayer(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: getWidth(context)/ 10
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: getSize(context, 50),),
                    headingRole(context, canGoBack: true),
                    SizedBox(height: getSize(context, 40),),
                    textControl("Merchant Account", context, size: getSize(context, 16),
                        color: colors.blueColor.withOpacity(0.8)),
                    SizedBox(height: getSize(context, 40),),
                    textControl("Company", context, size: getSize(context, 25), fontWeight: FontWeight.w500),
                    SizedBox(height: getSize(context, 10),),
                    textControl("Details", context, size: getSize(context, 25), fontWeight: FontWeight.w700),
                    SizedBox(height: getSize(context, 10),),
                    circle(getSize(context, 10), color: colors.pinkColor),
                    SizedBox(height: getSize(context, 40),),
                    textControl("Company Name", context, size: getSize(context, 15), font: fonts.proxima),
                    SizedBox(height: getSize(context, 20),),
                    textInputField(context, borderRadius: getSize(context, 16), height: getSize(context, 67), placeholder: "Name, eg. Alien Consult", onChange: (val){
                      setState(() {
                        companyName = val;
                      });
                    },),
                    SizedBox(height: getSize(context, 30),),
                    textControl("Company Logo", context, size: getSize(context, 15), font: fonts.proxima),
                    SizedBox(height: getSize(context, 10),),
                    _logo != null ?
                        Container(
                          height: getSize(context, 100),
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: Image.file(_logo),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: colors.pinkColor,
                                    borderRadius: BorderRadius.circular(getSize(context, 50))
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      iconSize: getSize(context, 15),
                                      padding: EdgeInsets.all(getSize(context, 5)),
                                      onPressed: getImage,
                                      color: Colors.white,
                                      icon: Icon(Icons.mode_edit),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                        :
                    GestureDetector(
                      onTap: getImage,
                      child: fileSelector(context),
                    ),
                    SizedBox(height: getSize(context, 30),),
                    textControl("Location", context, size: getSize(context, 15), font: fonts.proxima),
                    SizedBox(height: getSize(context, 20),),
                    textInputField(context, borderRadius: getSize(context, 16), height: getSize(context, 67), onChange: (val){
                      setState(() {
                        companyLocation = val;
                      });
                    }, placeholder: "Address, eg. 24 Alien street..."),
                    SizedBox(height:getSize(context, 60),),
                   Center(
                     child:  Stack(
                       children: <Widget>[
                         Hero(
                           tag: "goAbout",
                           child: Material(
                             type: MaterialType.transparency,
                             child: simpleButton("Continue", context, padV: 0, padH: 0),
                           ),
                         ),
                         Hero(
                           tag: "goCompanySelect",
                           child: Material(
                             type: MaterialType.transparency,
                             child: simpleButton("Continue", context,
                                 loading: loading,
                                 color: Colors.white.withOpacity(0.9),
                                 fontWeight: FontWeight.w500,
                                 onTap: (){
                                   submit(() => Navigator.of(context).pushNamed("/companySelect"));
                                 }
                             ),
                           )
                         )
                       ],
                     )
                   ),
                    SizedBox(height:getSize(context, 50),),
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



