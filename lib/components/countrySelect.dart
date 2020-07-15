import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';

Widget countryPicker(){
  return CountryCodePicker(
    onChanged: print,
    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
    initialSelection: 'NG',
    favorite: ['+234','NG'],
    // optional. Shows only country name and flag
    showCountryOnly: false,
    // optional. Shows only country name and flag when popup is closed.
    showOnlyCountryWhenClosed: false,
    // optional. aligns the flag and the Text left
    alignLeft: false,
    flagWidth: 50,
    padding: EdgeInsets.symmetric(horizontal: 0),
    textStyle: TextStyle(
        fontFamily: fonts.qanelas,
        fontSize: 17,
        color: colors.blueColor
    ),
    flagConWidth: 30,
    flagConHeight: 30,
    flagConPadH: 6,
    flagConPadV: 2,
    containerDecoration: BoxDecoration(
        color: colors.lightBlack,
        borderRadius: BorderRadius.circular(50)
    ),
  );
}
