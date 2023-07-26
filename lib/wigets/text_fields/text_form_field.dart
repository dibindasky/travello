import 'package:flutter/material.dart';
import 'package:travelapp/functions/validator_functions.dart';
import '../../constants/colors.dart';

// ignore: must_be_immutable
class FormFields extends StatelessWidget {
  FormFields(
      {super.key,
      this.textLabel,
      this.function,
      this.keyboardType,
      this.value = '',
      required this.textContol});

  String? textLabel;
  var keyboardType;
  var function;
  String value;
  TextEditingController textContol;

  bool ontaped = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      decoration: const BoxDecoration(
          color: whiteSecondary,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: textContol,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return 'enter $textLabel';
          } else if (!functionValidator(function, textContol.text)) {
            return function == isValidPassword && value.length < 8
                ? 'password must contains atleast 8 letters'
                : function == isValidTripName
                    ? 'enter a short name'
                    : 'enter valid $textLabel';
          } else {
            return null;
          }
        },
        // onTapOutside: (event) {
        //   changeColor();
        // },
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: textLabel,
        ),
      ),
    );
  }

  bool functionValidator(function, String text) {
    if (function == null) return true;
    if (function == isValidPhoneNumber) {
      return isValidPhoneNumber(text);
    } else if (function == isAlphabet) {
      return isAlphabet(text);
    } else if (function == isValidPassword) {
      return isValidPassword(text);
    } else if (function == isValidTripName(text)) {
      return isValidTripName(text);
    }
    return true;
  }
}
