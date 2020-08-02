import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:cloudinary_client/models/CloudinaryResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:spot_app/models/errorHandler.dart';
import 'package:spot_app/network/data.dart';
import 'package:spot_app/network/requestManage.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/helpers.dart';

void updateUserData(Map updateData, Function setStateWithStatus, BuildContext context, Function callback) async {
  UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
  String token = userOnBoardChangeNotifierModel.token;
  String userId = userOnBoardChangeNotifierModel.userData["userId"];

  Map<String, String> headers = networkData.setHeader(userBearer: true, userJson: true, token: token);
  String newUrl = networkData.getUsersUrl() + "/$userId";
  HttpRequests httpRequests = HttpRequests(url: newUrl, body: jsonEncode(updateData), headers: headers);
  setStateWithStatus(true);
  final response = await httpRequests.put();
  ErrorHandler errorHandler = ErrorHandler(response: response);
  if(!errorHandler.hasError){
    Map jsonResult = json.decode(response.body);
    Map<String, dynamic> userData = {};
    userData.addAll(jsonResult["data"]);
    userData.addAll(jsonResult["data"]["profile"]);
    userData["meta"] = null;
    userData.addAll(jsonResult["data"]["profile"]["meta"]);
    Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false).setUserData(userData);
    setStateWithStatus(false);
    callback();
  }
  else{

    Fluttertoast.showToast(msg: errorHandler.errorMessage ,backgroundColor: Colors.red.withOpacity(0.7), textColor: Colors.white);
    setStateWithStatus(false);

  }
}

Future<String> uploadImage(String path) async {
  CloudinaryClient client = new CloudinaryClient("827641323689264", "2O7-kRyPAS3WHaQE1ySnx4ZQwXA", "humberone");
  CloudinaryResponse response = await client.uploadImage(path);
  if(response.error != null){
    Fluttertoast.showToast(msg: "An error occured while uploading image. Try again", backgroundColor: Colors.red, textColor: Colors.white);
    return "false";
  }
  else{
    return response.url;
  }
}

Future<File> writeToFile(ByteData data, String name) async {
  final buffer = data.buffer;
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  var filePath = tempPath + '/$name'; // file_01.tmp is dump file, can be anything
  return new File(filePath).writeAsBytes(
      buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

Future<bool> willPopController(BuildContext context) async {
  return (await showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text('Are you sure?'),
      content: new Text('Do you want to exit Spot'),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text('No'),
        ),
        new FlatButton(
          onPressed: () => SystemNavigator.pop(),
          child: new Text('Yes'),
        ),
      ],
    ),
  )) ?? false;
}

Future<dynamic> fetchDeals(BuildContext context, {String extra = "", bool full = false}) async{
  UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
  HttpRequests httpRequests = HttpRequests(url: networkData.deal() + extra,
      headers: networkData.setHeader(userBearer: true, token:userOnBoardChangeNotifierModel.token));
  final response = await httpRequests.get();
  ErrorHandler errorHandler = new ErrorHandler(response: response);
  if(!errorHandler.hasError){
    final jsonResponse = json.decode(response.body);
    return full ? jsonResponse : jsonResponse["data"] == null ? [] : jsonResponse["data"];
  }
  else{
    Fluttertoast.showToast(msg: errorHandler.errorMessage, backgroundColor: Colors.red, textColor: Colors.white);
    return [];
  }
}

Future<dynamic> fetchMalls(BuildContext context) async{
  UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
  HttpRequests httpRequests = HttpRequests(url: networkData.mallUrl,
      headers: networkData.setHeader(userBearer: true, token:userOnBoardChangeNotifierModel.token));
  final response = await httpRequests.get();
  ErrorHandler errorHandler = new ErrorHandler(response: response);
  if(!errorHandler.hasError){
    final jsonResponse = json.decode(response.body);
    return jsonResponse["data"];
  }
  else{
    Fluttertoast.showToast(msg: errorHandler.errorMessage, backgroundColor: Colors.red, textColor: Colors.white);
    return [];
  }
}

Future<dynamic> getWallet(BuildContext context) async{
  UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
  HttpRequests httpRequests = HttpRequests(url: networkData.walletUrl + "?customerId=${userOnBoardChangeNotifierModel.userData["userId"]}",
      headers: networkData.setHeader(userBearer: true, token:userOnBoardChangeNotifierModel.token));
  final response = await httpRequests.get();
  ErrorHandler errorHandler = new ErrorHandler(response: response);
  if(!errorHandler.hasError){
    return json.decode(response.body);
  }
  else{
    Fluttertoast.showToast(msg: errorHandler.errorMessage, backgroundColor: Colors.red, textColor: Colors.white);
    return [];
  }
}

Future<dynamic> fetchDealsSummary(BuildContext context, String extra) async{
  UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
  HttpRequests httpRequests = HttpRequests(url: networkData.dealSummary() + extra,
      headers: networkData.setHeader(userBearer: true, token:userOnBoardChangeNotifierModel.token));
  final response = await httpRequests.get();
  ErrorHandler errorHandler = new ErrorHandler(response: response);
  if(!errorHandler.hasError){
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }
  else{
    Fluttertoast.showToast(msg: errorHandler.errorMessage, backgroundColor: Colors.red, textColor: Colors.white);
    return [];
  }
}

Future<Map> fetchCategories(BuildContext context) async{
  UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
  HttpRequests httpRequests = HttpRequests(url: networkData.getCategory(), headers: networkData.setHeader(userBearer: true, token:userOnBoardChangeNotifierModel.token));
  final response = await httpRequests.get();
  ErrorHandler errorHandler = new ErrorHandler(response: response);
  if(!errorHandler.hasError){
    final jsonResponse = json.decode(response.body);
    return formatCategories(jsonResponse["data"]);
  }
  else{
    Fluttertoast.showToast(msg: errorHandler.errorMessage, backgroundColor: Colors.red, textColor: Colors.white);
    return {};
  }
}

Future<dynamic> fetchPaymentCard(BuildContext context) async{
  UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
  HttpRequests httpRequests = HttpRequests(url: networkData.paymentCardsUrl + "?userId=${userOnBoardChangeNotifierModel.userData["userId"]}",
      headers: networkData.setHeader(userBearer: true, token:userOnBoardChangeNotifierModel.token));
  final response = await httpRequests.get();
  ErrorHandler errorHandler = new ErrorHandler(response: response);
  if(!errorHandler.hasError){
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }
  else{
    Fluttertoast.showToast(msg: errorHandler.errorMessage, backgroundColor: Colors.red, textColor: Colors.white);
    return {};
  }
}

Future<bool> fundWallet(BuildContext context, String auth, double amount) async {
  UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
  HttpRequests httpRequests = HttpRequests(url: networkData.paymentChargeAuthUrl, body: json.encode({
    "provider": "paystack",
    "authorization": auth,
    "amount": amount,
    "redirectUrl": "https://google.com"
  }),
      headers: networkData.setHeader(userBearer: true, token:userOnBoardChangeNotifierModel.token));
  final response = await httpRequests.post();
  ErrorHandler errorHandler = new ErrorHandler(response: response);
  if(!errorHandler.hasError){
    await Future.delayed(Duration(seconds: 5), () => true);
    return true;
  }
  else{
    try{
      Fluttertoast.showToast(msg: errorHandler.errorMessage, backgroundColor: Colors.red, textColor: Colors.white);
    }
    catch(e){
    }
    return false;
  }
}

Future<String> chargeWallet(BuildContext context, Map<String, dynamic> data, {bool showError = false}) async{
  UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
  HttpRequests httpRequests = HttpRequests(url: networkData.walletChargeUrl,
      body: json.encode(data),
      headers: networkData.setHeader(userBearer: true, userJson: true, token:userOnBoardChangeNotifierModel.token));
  final response = await httpRequests.post();
  ErrorHandler errorHandler = new ErrorHandler(response: response);
  if(!errorHandler.hasError){
    return json.decode(response.body)["reference"];
  }
  else{
    if(showError){
      Fluttertoast.showToast(msg: errorHandler.errorMessage, backgroundColor: Colors.red, textColor: Colors.white);
    }
    return "";
  }
}

Future<bool> verifyPaymentMain(BuildContext context, String ref) async{
  UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
  HttpRequests httpRequests = HttpRequests(url: networkData.paymentVerifyUrl + ref,
      headers: networkData.setHeader(userBearer: true, userJson: true, token:userOnBoardChangeNotifierModel.token));
  final response = await httpRequests.get();
  ErrorHandler errorHandler = new ErrorHandler(response: response);
  if(!errorHandler.hasError){
    return true;
  }
  else{
    Fluttertoast.showToast(msg: errorHandler.errorMessage, backgroundColor: Colors.red, textColor: Colors.white);
    return false;
  }
}

Future<bool> pinDeal(BuildContext context, int quantity, String productId, String paymentReference) async{
  UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
  var data = {
    "quantity": quantity,
    "productId": productId,
    "paymentReference": paymentReference
  };
  HttpRequests httpRequests = HttpRequests(url: networkData.pinDealUrl,
      body: json.encode(data),
      headers: networkData.setHeader(userBearer: true, userJson: true, token:userOnBoardChangeNotifierModel.token));
  final response = await httpRequests.post();
  ErrorHandler errorHandler = new ErrorHandler(response: response);
  if(!errorHandler.hasError){
    return true;
  }
  else{
    Fluttertoast.showToast(msg: errorHandler.errorMessage, backgroundColor: Colors.red, textColor: Colors.white);
    return false;
  }
}

dynamic initializePaymentMain(BuildContext context, double amount, String ref) async{
  UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
  Map<String, dynamic> data = {
    "amount": amount,
    "callbackUrl": "https://webhook.site/b83dfc04-cf13-47b3-a938-a042c2af97b9",
    "provider": "paystack",
    "redirectUrl": "http://spotapp.txt",
    "transactionId": ref
  };
  HttpRequests httpRequests = HttpRequests(url: networkData.paymentInitializerUrl,
      body: json.encode(data),
      headers: networkData.setHeader(userBearer: true, userJson: true, token:userOnBoardChangeNotifierModel.token));
  final response = await httpRequests.post();
  ErrorHandler errorHandler = new ErrorHandler(response: response);
  if(!errorHandler.hasError){
    return json.decode(response.body)["data"];
  }
  else{
    Fluttertoast.showToast(msg: errorHandler.errorMessage, backgroundColor: Colors.red, textColor: Colors.white);
    return {};
  }
}

Map formatCategories(var data){
  List<String> newData = [];

  for(int i = 0; i<data.length; i++){
    newData.add(data[i]["name"]);
  }

  return {
    "data": data,
    "newData": newData
  };
}

dynamic activeUser(BuildContext context, {String content}){
  UserOnBoardChangeNotifierModel userOnBoardChangeNotifierModel = Provider.of<UserOnBoardChangeNotifierModel>(context, listen: false);
  if(content == null) return userOnBoardChangeNotifierModel.userData;
  return userOnBoardChangeNotifierModel.userData[content];
}