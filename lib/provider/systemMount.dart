import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spot_app/network/data.dart';
import 'package:spot_app/network/requestManage.dart';


class SystemMount extends ChangeNotifier{
  List roles;

  SystemMount({roles}){
    roles = roles;
  }

  void getRoles() async {
    final headers = {
      "client_id": networkData.getClientId()
    };
    HttpRequests httpRequests = HttpRequests(url: networkData.getRolesUrl(), headers: headers);
    final response = await httpRequests.get();
    final jsonResponse = json.decode(response.body);
    final List responseData = jsonResponse["data"];
    setUpRoles(responseData);

  }

  void setUpRoles(List jsonRole){
    final newJsonRoles = jsonRole.where((i) => i["clientId"] == networkData.getClientId()).toList();
    this.roles = newJsonRoles;
    notifyListeners();
  }
}