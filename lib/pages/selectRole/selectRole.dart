import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:spot_app/components/bgColorLayer.dart';
import 'package:spot_app/components/button.dart';
import 'package:spot_app/components/headingRole.dart';
import 'package:spot_app/components/selectRoleBox.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/components/three-circles.dart';
import 'package:spot_app/models/options.dart';
import 'package:spot_app/provider/systemMount.dart';
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

class SelectRole extends StatefulWidget {
  @override
  _SelectRoleState createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  String _selectedRole;

  void _roleSelect(role){
    setState(() {
      _selectedRole = role;
    });
  }

  void initState(){
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void selectRole(String activeRole, List roles, UserOnBoardChangeNotifierModel model){
    final roleObj = roles.where((item) => item["name"].toString().toLowerCase() == activeRole.toLowerCase()).toList()[0];
    model.changeRole(activeRole, roleObj["id"]);
  }

  Widget build(BuildContext context) {
    final roles = Provider.of<SystemMount>(context);
    bool loading = false;//roles.roles == null ? true : false;
    return Scaffold(
      body:SizedBox.expand(
        child:  Stack(
          children: <Widget>[
            bgColorLayer(),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidth(context) / 10
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: getSize(context, 50),),
                    headingRole(context),
                    SizedBox(height: getSize(context, 50),),

                    textControl("Hello &", context, size: getSize(context, 25), fontWeight: FontWeight.w500),
                    SizedBox(height: getSize(context, 10),),
                    textControl("Welcome", context, size: getSize(context, 30), fontWeight: FontWeight.w700),
                    SizedBox(height: getSize(context, 10),),
                    circle(getSize(context, 10), color: colors.pinkColor),
                    SizedBox(height: getSize(context, 30),),
                    textControl("Create your account", context, size: getSize(context, 20), fontWeight: FontWeight.w700),
                    SizedBox(height: getSize(context, 40),),
                    textControl("Select Role", context, size: getSize(context, 17), font: fonts.proxima, fontWeight: FontWeight.w500),
                    SizedBox(height: getSize(context, 20),),
                    Consumer<UserOnBoardChangeNotifierModel>(
                      builder: (context, model, child){
                        return Container(
                          height: getSize(context, 200),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: <Widget>[
                              selectRoleBox(context,
                                  "assets/svgs/spotter.svg", "Spotter",
                                  imageWidth: getSize(context, 30),
                                  active: _selectedRole == spotRoles.spotter,
                                  onTap: (){
                                    if(loading) return;
                                    _roleSelect(spotRoles.spotter);
                                    selectRole(spotRoles.spotter, roles.roles, model);
                                  }
                              ),
                              selectRoleBox(
                                context,
                                  "assets/svgs/merchant.svg", "Merchant",
                                  imageWidth: getSize(context, 45), first: false,
                                  active: _selectedRole == spotRoles.merchant,
                                  onTap: (){
                                    if(loading) return;
                                    _roleSelect(spotRoles.merchant);
                                    selectRole(spotRoles.merchant, roles.roles, model);
                                  }
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: getSize(context, 60),),
                    Center(
                      child:  Stack(
                        children: <Widget>[
                          Hero(
                            tag: "goRole",
                            child: Material(type: MaterialType.transparency,child: simpleButton("Continue", context)),
                          ),
                          Hero(
                            tag: "goPhone",
                            child: Material(
                              type: MaterialType.transparency,
                              child: simpleButton("Continue", context, loading: loading, onTap: (){
                                if(loading) return;
                                if(_selectedRole == null){
                                  Fluttertoast.showToast(
                                    msg: "You need to select a role!",
                                  );
                                }
                                else{
                                  Navigator.of(context).pushNamed("/phoneSetup");
                                }
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getSize(context, 20),),

                    Center(
                      child: textControl("Already have an account", context,
                          size: getSize(context, 16), font: fonts.proxima, color: colors.pinkColor, underline: true),
                    ),
                    SizedBox(height: getSize(context, 20),)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



