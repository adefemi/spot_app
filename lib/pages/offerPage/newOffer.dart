import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/fileSelector.dart';
import 'package:spot_app/components/formGroup.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/phoneInputField.dart';
import 'package:spot_app/components/progressStep.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/models/errorHandler.dart';
import 'package:spot_app/network/customRequestHandler.dart';
import 'package:spot_app/network/data.dart';
import 'package:spot_app/network/requestManage.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class NewOffer extends StatefulWidget {
  const NewOffer(this.showSideBar);
  final Function showSideBar;

  @override
  _NewOfferState createState() => _NewOfferState();
}

class _NewOfferState extends State<NewOffer> {
  int activeStage = 1;
  Map<String, dynamic> userData;
  Map<String, dynamic> offerData = {};
  List<Asset> images = [];
  List<Map<String, dynamic>> imageControl = [];
  bool loading = false;
  bool loadingMain = false;
  UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel;

  onProgress(){
    if(activeStage == 3){
      saveData();
    }
    else{
      bool res = checkData(activeStage);
      if(!res)return;
      setState(() {
        activeStage = activeStage+1;
      });
    }
  }

  bool checkData(int index){
    bool state = true;
    if(index == 1){
      if(offerData['title'] == null || offerData["amount"] == null || offerData["description"] == null || offerData["quantity"] == null){
        state=false;
      }
    }

    else if(index == 2){
      if(offerData["maxTimeToClaim"] == null || offerData["endDate"] == null || offerData["startDate"] == null || offerData["distanceRange"] == null){
        state=false;
      }

    }

    if(!state){
      Fluttertoast.showToast(msg: "You need to fill in the fields to proceed", backgroundColor: Colors.red, textColor: Colors.white);
    }
    return state;
  }

  void saveData() async{
    setState(() {
      loading = true;
      loadingMain = true;
    });
    setupData();
    try{

      Map<String, String> newHeaders = networkData.setHeader(userBearer: true, userJson: true, token: userOnBoardChangeNotifierModel.token);
      HttpRequests httpRequests = HttpRequests(url: networkData.deal(), body: json.encode(offerData),
          headers:  newHeaders);
      final response = await httpRequests.post();
      ErrorHandler errorHandler = ErrorHandler(response: response);
      if(!errorHandler.hasError){
        Fluttertoast.showToast(msg: "Deal created successfully", backgroundColor: Colors.green, textColor: Colors.white);
        Navigator.of(context).pushReplacementNamed("/dashboard2", arguments: {"page": 1});
      }
      else{
        setState(() {
          loading = false;
          loadingMain = false;
        });
        Fluttertoast.showToast(msg: errorHandler.errorMessage, backgroundColor: Colors.red, textColor: Colors.white);
      }
    }
    catch(e){
      setState(() {
        loading = false;
        loadingMain = false;
      });
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red, textColor: Colors.white);
    }

  }

  void setupData(){
    try{
      final userData = userOnBoardChangeNotifierModel.userData;
      offerData["images"] = getImageUrls(imageControl);
      offerData["categoryId"] = userData["businessCategory"]["id"];
      offerData["address"] = userData["companyLocation"];
      offerData["latitude"] = 8.123;
      offerData["longitude"] = 8.123;
      offerData["maxTimeToClaim"] = int.parse(offerData["maxTimeToClaim"].toString().split(" ")[0]);
      offerData["distanceRange"] = double.parse(offerData["distanceRange"].toString()).round();
    }catch(e){
      setState(() {
        loading = false;
        loadingMain = false;
      });
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red, textColor: Colors.white);
    }
  }

  List<String> getImageUrls(List<dynamic> obj){
    List<String> newList = [];
    for(var i = 0; i<obj.length; i++){
      newList.add(obj[i]["url"]);
    }
    return newList;
  }

  Future getImage() async {
    if(imageControl.length == 3){
      Fluttertoast.showToast(msg: "Max images already selected", backgroundColor: Colors.red, textColor: Colors.white);
      return;
    }
    try {
      final List<Asset> resultList = await MultiImagePicker.pickImages(
        maxImages: 3 - imageControl.length,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Spot App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      setupImageLoading(resultList);
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red, textColor: Colors.white);
    }
  }

  void setupImageLoading(List<Asset> res) async{
    setState(() {
      loading = true;
    });
    var oldData = imageControl;
    for(int i = 0; i<res.length; i++){
      var data = {
        "asset": res[i],
        "identifier": "${i + imageControl.length < 1 ? 0 : oldData.length}",
        "loading": true
      };
      oldData.add(data);
      setState(() {
        imageControl = oldData;
      });
    }

    for(int i = 0; i<oldData.length; i++){
      if(oldData[i]["loading"]){
        var data = await oldData[i]["asset"].getByteData();
        File file = await writeToFile(data, oldData[i]["asset"].name);
        String uploadUrl = await uploadImage(file.path);

        int activeIndex;
        for(int j = 0; j<imageControl.length; j++){
          if(imageControl[j]["identifier"] == oldData[i]["identifier"]){
            activeIndex = j;
            break;
          }
        }
        var tempData = imageControl[activeIndex];

        tempData["loading"] = false;
        tempData["url"] = uploadUrl;
        setState(() {
          imageControl[activeIndex] = tempData;
        });
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      userData = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false).userData;
    });
    userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
  }

  void changeData(String key, dynamic value){
    setState(() {
      offerData[key] = value;
    });
  }
  
  void removeImage(var identifier){
    int activeIndex;
    var oldData = imageControl;
    for(int j = 0; j<imageControl.length; j++){
      if(imageControl[j]["identifier"] == identifier){
        activeIndex = j;
        break;
      }
    }
    oldData.removeAt(activeIndex);
    List<Map<String, dynamic>> newData  = [];
    for(int i = 0; i<oldData.length; i++){
      var data = {
        "asset": oldData[i]["asset"],
        "identifier": "$i",
        "loading":  oldData[i]["loading"],
        "url": oldData[i]["url"]
      };
      newData.add(data);
    }
    setState(() {
      imageControl = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        bgColorLayer(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox.expand(
            child: Stack(
              children: <Widget>[

                Container(

                  padding: EdgeInsets.symmetric(
                      horizontal: getWidth(context) / 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: getSize(context, 270),),
                        textControl(
                            activeStage == 3 ? "Upload images" : "Tell us about it", context, fontWeight: FontWeight.w600, color: colors.blueColor3),
                        SizedBox(height: getSize(context, activeStage == 3 ? 0 : 30),),
                        activeStage == 1 ? 
                        stage1(context, offerData, changeData) : 
                        activeStage == 2 ? 
                        stage2(context,offerData, changeData) : 
                        stage3(context, getImage, imageControl, removeImage),
                        SizedBox(height: getSize(context, activeStage == 1 ? 30 : 20),),
                        Center(
                          child: simpleButton(activeStage == 2 ? "Upload Images" : "Create deal",
                              context, padH: getSize(context, activeStage == 1 ? 130 : 200),
                              disabled: activeStage > 2 ? imageControl.length < 1 || loading: false,
                              loading: loadingMain,
                              color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w400, fontSize: 15,
                              child: activeStage == 1 ? Icon(Icons.chevron_right, size: getSize(context, 25), color: Colors.white,) : null,
                              onTap: onProgress
                          ),
                        ),
                        SizedBox(height: getSize(context, 50),),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: getSize(context, 250),
                  child:  Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: colors.blueColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(getSize(context, 80)))
                        ),
                      ),
                      Positioned(
                        right: -getSize(context, getWidth(context) / 10),
                        top: getSize(context, 0),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              -getSize(context, 20) * 3.142 / 180
                          ),
                          child: Transform.scale(scale: getSize(context, 1.2),
                            child: threeDots(
                                context, color: Colors.white.withOpacity(0.05)),),
                        ),
                      ),
                      Container(
                        width: getSize(context, getWidth(context) / 2),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.008),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(getSize(context, 80)))
                        ),
                      ),
                      Container(

                        padding: EdgeInsets.symmetric(
                            horizontal: getSize(context, getWidth(context) / 10),
                            vertical: getSize(context, 10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            headingRole2(context, "Create a Deal", togNav: widget.showSideBar, solid: true, canGoBack: true, fontSize: 15, avatar: userData["logo"]),
                            Column(
                              children: <Widget>[
                                textControl(
                                    "New Offer", context, size: getSize(context, 25),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                                SizedBox(height: getSize(context, 15),),
                                circle(getSize(context, 10), color: colors.pinkColor),
                                SizedBox(height: getSize(context, 25),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    progressStep(context, active: activeStage == 1 ? true : false),
                                    progressStep(context, active: activeStage == 2 ? true : false),
                                    progressStep(context, isLast: true, active: activeStage == 3 ? true : false),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            )
          ),
        )
      ],
    );
  }
}

Widget stage1(BuildContext context, Map<String, dynamic> offerData, Function updateOfferData){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      formGroup(context, textInputField(context, placeholder: "", height: 67, onChange: (e)=>updateOfferData("title", e), value: offerData["title"] == null ? "" : offerData["title"]), label: "Title"),
      formGroup(context, textInputField(context, placeholder: "", height: 67, onChange: (e)=>updateOfferData("amount", e), type: "number"),  label: "Price"),
      formGroup(context, textInputField(context, placeholder: "", height: 100, onChange: (e)=>updateOfferData("description", e), type: "multiline"), label: "Description",),
      formGroup(context, textInputField(context, placeholder: "", height: 67, onChange: (e)=>updateOfferData("quantity", e), type: "number"), label: "Quantity"),
    ],
  );
}
Widget stage2(BuildContext context, Map<String, dynamic> offerData, Function updateOfferData){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      formGroup(context, inputSelectField(context, value: offerData["maxTimeToClaim"] == null ? "Select time" : offerData["maxTimeToClaim"], height: 67,
          itemList: ["Select time", "1 day", "2 days", "3 days", "4 days", "5 days", "6 days", "7 days"],
          onSelect: (value){
            updateOfferData("maxTimeToClaim", value);
          }),
          label: "Maximum time to Claim"),
      formGroup(context, datePicker(context, height: 67, value: offerData["startDate"] == null ? null : offerData["startDate"],
          onSelect: (value){
            updateOfferData("startDate", value);
          }),
          label: "Start Date"),
      offerData["startDate"] == null ? SizedBox() : formGroup(context,
          datePicker(context, height: 67, value: offerData["endDate"] == null ? null : offerData["endDate"],
          startTime: DateTime.parse(offerData["startDate"]),
          onSelect: (value){
            updateOfferData("endDate", value);
          }),
          label: "Deadline"),
      formGroup(context, sliderWidget(context, value: offerData["distanceRange"] == null ? 1.0 : offerData["distanceRange"],
          onSelect: (value){
            updateOfferData("distanceRange", value);
          }), label: "Range in Kilometeres"),
    ],
  );
}



Widget stage3(BuildContext context, Function imageSelector, List<Map<String, dynamic>> imageData, Function removeImage){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: getSize(context, 15),),
      textControl("Maximum of 3 images, less than 500kb", context, size: 15, color: colors.blueColor.withOpacity(0.6)),
      SizedBox(height: getSize(context, 20),),
      fileSelector(context, height: 180, borderRadius: 50, onClick: imageSelector, child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset("assets/svgs/upload.svg", color: colors.pinkColor,),
          SizedBox(height: getSize(context, 10),),
          textControl("Add Image", context, size: 14, color: colors.blueColor.withOpacity(0.8))
        ],
      )),
      SizedBox(height: getSize(context, 30),),
      Column(
        children: imageData.map((e) => new Container(
          height: getSize(context, 50),
          padding: EdgeInsets.symmetric(horizontal: getSize(context, 20)),
          margin: EdgeInsets.only(bottom: getSize(context, 20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              e["loading"] ? Container(height: getSize(context, 50), width: getSize(context, 50), color: Colors.grey,) :
              Image.network(e["url"], width: getSize(context, 50), height: getSize(context, 50),),
              e["loading"] ? SpinKitCircle(color: Colors.pinkAccent, size: 22,) :
              IconButton(icon: Icon(Icons.close, size: 15, color: Colors.red,), onPressed: (){removeImage(e["identifier"]);},)
            ],
          ),
        )).toList(),
      )

    ],
  );
}
