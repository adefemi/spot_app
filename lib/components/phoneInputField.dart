import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spot_app/components/countrySelect.dart';
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

Widget textInputField(BuildContext context, {double borderRadius: 15, double height: 82, Function onChange, String placeholder:"Enter something", FocusNode focusNode, String errorText, bool multiLine: false}){
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
              fontSize: getSize(context, 16),
              fontFamily: fonts.proxima,
              fontWeight: FontWeight.w500,
              color: Colors.black
          ),
          onChanged: onChange,
          focusNode: focusNode,
          keyboardType: multiLine ? TextInputType.multiline : TextInputType.text,
          maxLines: multiLine ? 5 : 1,
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
      height: getSize(context, height < 75 ? 75 : height),
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
            fontSize: getSize(context, 15),
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

Widget sliderWidget(BuildContext context, {Function onSelect, double value, double min:1, double max: 10}){
  return Slider(
      value: value,
      min: min,
      max: max,
      divisions: null,
      activeColor: colors.pinkColor,
      inactiveColor: colors.blueLight2,
      label: 'Set a value',
      onChanged: onSelect,
      semanticFormatterCallback: (double newValue) {
        return '${newValue}km';
      }
  );
}