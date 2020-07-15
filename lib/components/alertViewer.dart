import 'package:flutter/material.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

Widget alertViewer(BuildContext context, {bool status: false, Widget child, Function closeAlert}){
  return IgnorePointer(
   ignoring: !status,
    child: Stack(
      children: <Widget>[
        GestureDetector(
          onTap: closeAlert,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: getHeight(context),
            color: status ? Colors.black.withOpacity(0.4) : Colors.transparent,
          ),
        ),
        AnimatedPositioned(
          right: 0,
          left: 0,
          bottom: status ? 0 : -getHeight(context),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context)/10, vertical: getSize(context, 20)),
              decoration: BoxDecoration(
                  color: colors.searchWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(getSize(context, 40)),
                    topRight: Radius.circular(getSize(context, 40)),
                  )
              ),
              child: status ? child : SizedBox()
          ),
        )
      ],
    ),
  );
}