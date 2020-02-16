import 'package:flutter/material.dart';


class UserOnBoardChangeNotifierModel extends ChangeNotifier{
  String activeRole;

  void changeRole(String role){
    activeRole = role;

    notifyListeners();
  }
}