import 'package:flutter/material.dart';
import 'package:spot_app/components/headingRole2.dart';
import 'package:spot_app/components/insertContent.dart';
import 'package:spot_app/components/settingsItem.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/helpers.dart';

class SettingsMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(context)/15),
          child: headingRole2(context, "Settings", solid: true, canGoBack: true),
        ),
        elevation: 0,
        backgroundColor: colors.blueColor,
      ),
      backgroundColor: colors.lightBlue1,
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: -getSize(context, getWidth(context)/5),
                  top: getSize(context, 50),
                  child: circle(50, color: Colors.white.withOpacity(0.1))
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(getSize(context, 100))
                  ),
                  child: Container(
                    color: colors.blueColor,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: getSize(context, getWidth(context) / 7), vertical: getSize(context, 20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: getSize(context, 10),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage:NetworkImage("https://cdn.pixabay.com/photo/2016/08/28/13/12/secondlife-1625903_960_720.jpg"),
                                  radius: getSize(context, 30),
                                ),
                                SizedBox(width: getSize(context, 15),),
                                textControl("Hassan Stores", context, size: 16, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w600)
                              ],
                            ),
                            insertContent(context, color: Colors.white.withOpacity(0.3), child: insertContent(context, width: 38, height: 38,
                                child: Icon(Icons.edit, size: getSize(context, 20), color: Colors.white.withOpacity(0.3),), color: colors.blueColor
                            ))
                          ],
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            flex: 8,
            fit: FlexFit.tight,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context)/7, vertical: getSize(context, 30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    settingListContent(context, "assets/svgs/bell.svg", "Notifications", canToggle: true),
                    settingListContent(context, "assets/svgs/userSetting.svg", "Company Profile", onTap: () => gotoPage(context, "/companyProfile", repNamed: false)),
                    settingListContent(context, "assets/svgs/logout.svg", "Log Out", last: true),
                  ],
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}
