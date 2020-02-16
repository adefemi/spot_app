import 'package:flutter/material.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/fileSelector.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:image_picker/image_picker.dart';

class AboutCompany extends StatefulWidget {
  @override
  _AboutCompanyState createState() => _AboutCompanyState();
}

class _AboutCompanyState extends State<AboutCompany> {
  dynamic _logo;
  String companyName;
  String companyLocation;

  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _logo = image;
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
                horizontal: MediaQuery.of(context).size.width / 10
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 50,),
                    headingRole(context, canGoBack: true),
                    SizedBox(height: 40,),
                    textControl("Merchant Account", size: 16,
                        color: colors.blueColor.withOpacity(0.8)),
                    SizedBox(height: 40,),
                    textControl("Company", size: 25, fontWeight: FontWeight.w500),
                    SizedBox(height: 10,),
                    textControl("Details", size: 25, fontWeight: FontWeight.w700),
                    SizedBox(height: 10,),
                    circle(10, color: colors.pinkColor),
                    SizedBox(height: 40,),
                    textControl("Company Name", size: 15, font: fonts.proxima),
                    SizedBox(height: 20,),
                    textInputField(borderRadius: 16, height: 67, placeholder: "Name, eg. Alien Consult", onChange: (val){
                      setState(() {
                        companyName = val;
                      });
                    },),
                    SizedBox(height: 30,),
                    textControl("Company Logo", size: 15, font: fonts.proxima),
                    SizedBox(height: 20,),
                    _logo != null ?
                        Container(
                          height: 100,
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
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      iconSize: 15,
                                      padding: EdgeInsets.all(5),
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
                    SizedBox(height: 30,),
                    textControl("Location", size: 15, font: fonts.proxima),
                    SizedBox(height: 20,),
                    textInputField(borderRadius: 16, height: 67, onChange: (val){
                      setState(() {
                        companyLocation = val;
                      });
                    }, placeholder: "Address, eg. 24 Alien street..."),
                    SizedBox(height:60,),
                   Center(
                     child:  Stack(
                       children: <Widget>[
                         Hero(
                           tag: "goAbout",
                           child: simpleButton("Continue"),
                         ),
                         Hero(
                           tag: "goCompanySelect",
                           child: simpleButton("Continue",
                               color: Colors.white.withOpacity(0.9),
                               padH: 60,
                               fontWeight: FontWeight.w500,
                             onTap: (){
                                Navigator.of(context).pushNamed("/companySelect");
                             }
                           ),
                         )
                       ],
                     )
                   ),
                    SizedBox(height:50,),
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



