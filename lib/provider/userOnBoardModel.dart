import 'package:flutter/material.dart';


class UserOnBoardChangeNotifierModel extends ChangeNotifier{
  String activeRole;
  String activeRoleId;
  String phoneNumber;
  String token;
  Map<String, dynamic> activeCat;
  Map<String, dynamic> userData;

  void changeRole(String role, String roleId){
    activeRole = role;
    activeRoleId = roleId;

    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber){
    this.phoneNumber = phoneNumber;

    notifyListeners();
  }

  void setToken(String token){
    this.token = token;

    notifyListeners();
  }

  void setUserData(Map<String, dynamic> userdata){
    userData = userdata;

    notifyListeners();
  }

  void setActiveCatId(Map<String, dynamic> data){
    activeCat = data;

    notifyListeners();
  }
}