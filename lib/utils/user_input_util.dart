import 'package:flutter/material.dart';

import '../constants/colors.dart';

class UserInputField extends StatelessWidget {
  TextEditingController userField;
  bool ispass;
  UserInputField({super.key, required this.userField, required this.ispass});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        obscureText: ispass,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
            fillColor: textInputBackgroundColor,
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
                borderRadius: BorderRadius.circular(8.0))),
        controller: userField,
      ),
    );
  }
}
