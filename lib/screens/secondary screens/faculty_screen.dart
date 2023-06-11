import 'package:flutter/material.dart';
import 'package:project_um/constants/colors.dart';
import 'package:project_um/utils/block_image.dart';

import '../notifications_screen.dart';

class FacultyScreen extends StatelessWidget {
  const FacultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Faculty Information"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationScreen()));
              },
              icon: Icon(Icons.add_alert_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: Column(children: [
          BlockImage(
              name: "Department of Technology",
              imageName: "2",
              colorName: greenSecondaryColor),
          BlockImage(
              name: "Department of Commerce",
              imageName: "4",
              colorName: redSecondaryColor)
        ]),
      ),
    );
  }
}
