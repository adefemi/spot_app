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
import 'package:spot_app/provider/userOnBoardModel.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';

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

  Widget build(BuildContext context) {
    return Scaffold(
      body:SizedBox.expand(
        child:  Stack(
          children: <Widget>[
            bgColorLayer(),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 10
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 50,),
                    headingRole(context),
                    SizedBox(height: 50,),

                    textControl("Hello &", size: 25, fontWeight: FontWeight.w500),
                    SizedBox(height: 10,),
                    textControl("Welcome", size: 30, fontWeight: FontWeight.w700),
                    SizedBox(height: 10,),
                    circle(10, color: colors.pinkColor),
                    SizedBox(height: 30,),
                    textControl("Create your account", size: 20, fontWeight: FontWeight.w700),
                    SizedBox(height: 40,),
                    textControl("Select Role", size: 17, font: fonts.proxima, fontWeight: FontWeight.w500),
                    SizedBox(height: 20,),
                    Consumer<UserOnBoardChangeNotifierModel>(
                      builder: (context, model, child){
                        return Container(
                          height: MediaQuery.of(context).size.height / 3.5 > 200 ? 200 : MediaQuery.of(context).size.height / 3.5,
                          child: Flex(
                            direction: Axis.horizontal,
                            children: <Widget>[
                              selectRoleBox(
                                  "assets/svgs/spotter.svg", "Spotter",
                                  imageWidth: MediaQuery.of(context).size.height / 25 > 30 ?
                                  30 : MediaQuery.of(context).size.height / 25,
                                  active: _selectedRole == spotRoles.spotter,
                                  onTap: (){
                                    _roleSelect(spotRoles.spotter);
                                    model.changeRole(spotRoles.spotter);
                                  }
                              ),
                              selectRoleBox(
                                  "assets/svgs/merchant.svg", "Merchant",
                                  imageWidth: MediaQuery.of(context).size.height / 17 > 50 ?
                                  50 : MediaQuery.of(context).size.height / 17, first: false,
                                  active: _selectedRole == spotRoles.merchant,
                                  onTap: (){
                                    _roleSelect(spotRoles.merchant);
                                    model.changeRole(spotRoles.merchant);
                                  }
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 60,),
                    Center(
                      child:  Stack(
                        children: <Widget>[
                          Hero(
                            tag: "goRole",
                            child: simpleButton("Continue"),
                          ),
                          Hero(
                            tag: "goPhone",
                            child: simpleButton("Continue", onTap: (){
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
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),

                    Center(
                      child: textControl("Already have an account",
                          size: 16, font: fonts.proxima, color: colors.pinkColor, underline: true),
                    ),
                    SizedBox(height: 20,)
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



