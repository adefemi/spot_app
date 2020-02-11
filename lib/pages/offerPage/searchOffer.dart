import 'package:flutter/material.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/searchPanel.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:provider/provider.dart';

class SearchOffer extends StatelessWidget {
  const SearchOffer(this.showSideBar);
  final Function showSideBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            bgColorLayer(),
            GestureDetector(
              onTap: (){
                showSideBar();
                },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 10),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50,),
                    textControl("Hello Temi", size: 18, fontWeight: FontWeight.w600)
                  ],
                ),
              ),
            ),
            searchPanel(context),
          ],
        ),
      ),
    );
  }
}
