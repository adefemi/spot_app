import 'package:flutter/material.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/searchPanel.dart';
import 'package:spot_app/components/textControl.dart';

class SearchOffer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            bgColorLayer(),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 10),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50,),
                textControl("Hello Temi", size: 18, fontWeight: FontWeight.w600)
              ],
            ),
          ),
            searchPanel(context),
          ],
        ),
      ),
    );
  }
}
