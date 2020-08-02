import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spot_app/components/countrySelect.dart';
import 'package:spot_app/components/textControl.dart';
import 'package:spot_app/utils/colors.dart';
import 'package:spot_app/utils/fonts.dart';
import 'package:spot_app/utils/helpers.dart';

class NumberTextInputFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 4) {
      if(newTextLength < 7){
        newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ' ');
        if (newValue.selection.end >= 3) selectionIndex += 1;
      }

      else if(newTextLength >= 7){
        newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ' ' + newValue.text.substring(3, usedSubstringIndex = 6) + ' ');
        if (newValue.selection.end >= 6) selectionIndex += 2;
      }


    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
final _mobileFormatter = NumberTextInputFormatter();

Widget phoneInputField(BuildContext context, {String value: "", Function setValue, bool isCorrect: false}){
  return Container(
    height: getSize(context, 82),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(getSize(context, 20)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.01),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset.fromDirection(1, 10)
          )
        ]
    ),
    padding: EdgeInsets.symmetric(horizontal: getSize(context, 20)),
    child: Center(
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          countryPicker(),
          SizedBox(width: 10,),

          Flexible(
            flex: 1,
            child: TextField(
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
                _mobileFormatter
              ],
              onChanged: (newValue){
                setValue(newValue);
              },
              style: TextStyle(
                fontSize: getSize(context, 17),
                fontFamily: fonts.qanelas,
                fontWeight: FontWeight.w600,
                color: colors.blueColor
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '803 344 8299',
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.3),
                  fontWeight: FontWeight.w500,
                  fontSize: getSize(context, 15)
                )
              ),
            ),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: isCorrect ? 1 : 0,
            child: Container(
              width: getSize(context, 26),
              height: getSize(context, 26),
              decoration: BoxDecoration(
                  color: colors.blueLight,
                  borderRadius: BorderRadius.circular(getSize(context, 40))
              ),
              child: Icon(Icons.check, size: getSize(context, 14), color: Colors.white,),
            ),
          )
        ],
      ),
    ),
  );
}

Widget otpInputField(BuildContext context, {double borderRadius: 15, double height: 82, Function onChange, bool isFocused = false, FocusNode otpFocusNode, bool isFirst: false}){
  return Container(
      height: getSize(context, height),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset.fromDirection(1, 10)
          )
        ]
      ),
      padding: EdgeInsets.symmetric(horizontal: getSize(context, 20)),
      child: Center(
        child: TextField(
          style: TextStyle(
              fontSize: getSize(context, 18),
              fontFamily: fonts.proxima,
              fontWeight: FontWeight.w600,
              color: colors.blueColor
          ),
          autofocus: isFirst,
          onChanged: onChange,
          maxLength: 1,
          focusNode: otpFocusNode,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: ""
          ),
        ),
      ),
  );
}

class CustomRangeTextInputFormatter extends TextInputFormatter {

  int min;
  int max;

  CustomRangeTextInputFormatter(this.min, this.max);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,TextEditingValue newValue,) {
    if(newValue.text == '')
      return TextEditingValue().copyWith(text: "");
    else if(int.parse(newValue.text) < min){
      Fluttertoast.showToast(msg: "Minimum value is $min", backgroundColor: Colors.red, textColor: Colors.white);
      return TextEditingValue().copyWith(text: min.toString());
    }
    else if(int.parse(newValue.text) > max){
      Fluttertoast.showToast(msg: "Maximum value is $max", backgroundColor: Colors.red, textColor: Colors.white);
      return TextEditingValue().copyWith(text: max.toString());
    }
    return newValue;
  }
}

Widget textInputField(BuildContext context, {double borderRadius: 15, String value = "", double height: 82, Function onChange, String placeholder:"Enter something",
  FocusNode focusNode, String errorText, bool multiLine: false, String type = "text", bool range: false, int min: 0, int max: 0}){
  List<TextInputFormatter> formatList = [];
  if(type == "number"){
    formatList.add(WhitelistingTextInputFormatter.digitsOnly);
    if(range){
      formatList.add(CustomRangeTextInputFormatter(min, max));
    }
  }
  return Container(
      height: getSize(context, height),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset.fromDirection(1, 10)
          )
        ]
      ),
      padding: EdgeInsets.symmetric(horizontal: getSize(context, 20)),
      child: Center(
        child: TextFormField(
          style: TextStyle(
              fontSize: getSize(context, 16),
              fontFamily: fonts.proxima,
              fontWeight: FontWeight.w500,
              color: Colors.black
          ),
          onChanged: onChange,
//          controller: _txtCon,
          focusNode: focusNode,
          initialValue: value,
          keyboardType: type == "multiline" ? TextInputType.multiline : type == "number" ? TextInputType.number : TextInputType.text,
          inputFormatters: formatList,
          maxLines: type == "multiline" ? 5 : 1,
          decoration: InputDecoration(
            border: InputBorder.none,
            errorText: errorText,
            counterText: "",
              hintText: placeholder,
              hintStyle: TextStyle(
                  fontSize: getSize(context, 15),
                  fontFamily: fonts.proxima,
                  color: Colors.black.withOpacity(0.3)
              )
          ),
        ),
      ),
  );
}

Widget inputSelectField(BuildContext context, {double borderRadius: 15, String placeholder, String value, List<String> itemList, Function onSelect, double height: 82}){
  return Container(
      height: getSize(context, height < 65 ? 65 : height),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset.fromDirection(1, 10)
          )
        ]
      ),
      padding: EdgeInsets.symmetric(horizontal: getSize(context, 30)),
      child: DropdownButtonFormField(
        onChanged: onSelect,
        value: value,
        icon: Icon(Icons.keyboard_arrow_down, color: colors.pinkColor,),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none
          ),
            hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: getSize(context, 20),
            fontFamily: fonts.proxima,
            color: Colors.black.withOpacity(0.3)
          )
        ),
        iconSize: getSize(context, 20),
        style: TextStyle(
            fontSize: getSize(context, 15),
            fontFamily: fonts.proxima,
            color: Colors.black
        ),
        items: itemList.map((String val) {
          return DropdownMenuItem(
            key: ValueKey(val),
            value: val,
            child: Text(val),
          );
        }).toList(),
        isExpanded: true,
      )
  );
}

Widget sliderWidget(BuildContext context, {Function onSelect, double value = 0.0, double min:1, double max: 10}){
  return Slider(
      value: value,
      min: min,
      max: max,
      divisions: 10,
      activeColor: colors.pinkColor,
      inactiveColor: colors.blueLight2,
      label: value.round().toString(),
      onChanged: onSelect,
      semanticFormatterCallback: (double newValue) {
        return '${newValue}km';
      }
  );
}

Widget datePicker(BuildContext context, {Function onSelect, String value, double height, double borderRadius = 16, DateTime startTime}){
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startTime == null ? selectedDate : startTime,
        firstDate: startTime == null ? selectedDate.subtract(Duration(days: 0)) : startTime,
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      onSelect("${picked.toLocal()}".split(' ')[0]);
  }

  String selected = value == null ? "select date" : value;

  return GestureDetector(
    onTap: () => _selectDate(context),
    child: Container(
      height: getSize(context, height < 65 ? 65 : height),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.01),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset.fromDirection(1, 10)
            )
          ]
      ),
      padding: EdgeInsets.symmetric(horizontal: getSize(context, 30)),
      child: Center(
        child: textControl(selected, context, size: 15),
      ),
    ),
  );
}