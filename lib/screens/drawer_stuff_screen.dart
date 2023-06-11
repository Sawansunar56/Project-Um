import 'package:flutter/material.dart';
import 'package:project_um/authentication/auth.dart';

import '../constants/colors.dart';

class DrawerStuffScreen extends StatelessWidget {
  const DrawerStuffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          color: blueSecondaryColor,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Students Hub",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
        ),
        Expanded(child: Text("")),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: () {
              AuthMethods().signOut();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(7.0)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80.0, vertical: 14),
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        )
        // Text("hello")
      ],
    );
  }
}
