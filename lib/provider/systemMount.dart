import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spot_app/models/errorHandler.dart';
import 'package:spot_app/network/data.dart';
import 'package:spot_app/network/requestManage.dart';


class SystemMount extends ChangeNotifier{
  List roles;

  SystemMount({roles}){
    roles = roles;
  }

  void getRoles() async {
    final headers = {
      "client-id": networkData.getClientId()
    };
    HttpRequests httpRequests = HttpRequests(url: networkData.getRolesUrl(), headers: headers);
    final response = await httpRequests.get();
    ErrorHandler errorHandler = new ErrorHandler(response: response);
    if(!errorHandler.hasError){
      final jsonResponse = json.decode(response.body);
      final List responseData = jsonResponse["data"];
      setUpRoles(responseData);
    }
    else{
      Fluttertoast.showToast(msg: errorHandler.errorMessage, backgroundColor: Colors.red, textColor: Colors.white);
    }
  }

  void setUpRoles(List jsonRole){
    final newJsonRoles = jsonRole.where((i) => i["clientId"] == networkData.getClientId()).toList();
    this.roles = newJsonRoles;
    notifyListeners();
  }
}