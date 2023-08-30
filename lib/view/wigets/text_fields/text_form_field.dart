// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../controller/functions/validator_functions.dart';

class FormFields extends StatelessWidget {
  FormFields(
      {super.key,
      this.textLabel,
      this.function,
      this.keyboardType,
      this.value = '',
      this.obscure = false,
      required this.textContol});

  String? textLabel;
  var keyboardType;
  var function;
  final bool obscure;
  final String value;
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
        obscureText: obscure,
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
    } else if (function == isValidTripName) {
      return isValidTripName(text);
    }
    return true;
  }
}
