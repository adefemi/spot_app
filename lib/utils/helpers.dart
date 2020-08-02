import 'package:flutter/material.dart';
import 'dart:math';

double getHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}

double getWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}

void printWrapped(String text) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

double getSize(BuildContext context, double maxSize){
  double deleteVariable = 600;
  if(getHeight(context) > 900 && getHeight(context) <= 1200){
    deleteVariable = 700;
  }
  else if(getHeight(context) <= 900){
    deleteVariable = 800;
  }
  double newSize = getHeight(context) * maxSize / deleteVariable;
  if(newSize > maxSize){
    newSize = maxSize;
  }
  return newSize;
}

double getSizeWidth(BuildContext context, double maxSize){
  double newSize = getWidth(context) * maxSize / 1000;
  if(newSize > maxSize){
    newSize = maxSize;
  }
  return newSize;
}

void gotoPage(BuildContext context, String link, {int extra, bool repNamed: true}){

  if(extra != null){
    if(repNamed){
      Navigator.of(context).pushReplacementNamed(link, arguments: {"page": extra});
    }
    else{
      Navigator.of(context).pushNamed(link, arguments: {"page": extra});
    }
  }
  else{
    if(repNamed){
      Navigator.of(context).pushReplacementNamed(link);
    }
    else{
      Navigator.of(context).pushNamed(link);
    }
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));