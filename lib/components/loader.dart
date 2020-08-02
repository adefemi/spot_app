import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';
import 'package:skeleton_text/skeleton_text.dart';


Widget loaderMain(BuildContext context, {bool status=false}){
  if(!status){
    return SizedBox();
  }
  return Container(
    height: getHeight(context),
    width: getWidth(context),
    color: Colors.white.withOpacity(0.3),
    child: Center(
      child: SpinKitCircle(color: colors.blueColor, size: getSize(context, 20),),
    ),
  );
}

Widget offerLoader(BuildContext context, {double height: 100}){
  return SkeletonAnimation(
    child: Container(
      width: getWidth(context),
      height: getSize(context, height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(context, 30)),
        color: Colors.grey[300],
      ),
    ),
  );
}

Widget simpleLoader(BuildContext context, {double width = 0, double height = 0, double radius = 0}){
  return SkeletonAnimation(
    child: Container(
      width: getSize(context, width),
      height: getSize(context, height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(context, radius)),
        color: Colors.grey[300],
      ),
    ),
  );
}

Widget offerLoaders(BuildContext context, {int count = 3, double spacing = 20}){

  List<Widget> getLoaders(){
    List<Widget> _widgetsList = [];
    for(int i = 0; i<count; i++){
      _widgetsList.add(offerLoader(context));
      if(i < count - 1){
        _widgetsList.add(SizedBox(height: getSize(context, spacing),));
      }
    }
    return _widgetsList;
  }

  return Column(
    children: getLoaders(),
  );
}