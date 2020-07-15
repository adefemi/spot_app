import 'package:flutter/material.dart';


class UserOnBoardChangeNotifierModel extends ChangeNotifier{
  String activeRole;
  String activeRoleId;
  String phoneNumber;
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

  void setUserData(Map<String, dynamic> userdata){
    userData = userdata;

    notifyListeners();
  }
}