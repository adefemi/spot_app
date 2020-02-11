import 'package:flutter/material.dart';
import 'package:spot_app/utils/colors.dart';


Widget bgColorLayer(){
  return SizedBox.expand(
    child:  Container(
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              child: Container(
                color: colors.lightBlue1,
//                        child: Text("Flex 1"),
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                color: colors.lightBlur,
//                        child: Text("Flex 2"),
              ),
              flex: 1,
            )
          ],
        )
    ),
  );
}