import 'package:flutter/material.dart';

import '../constants/colors.dart';

class HeaderText extends StatelessWidget {
  String givenText;
  HeaderText({super.key, required this.givenText});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        givenText,
        style: TextStyle(
            fontSize: 21, color: primaryColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
