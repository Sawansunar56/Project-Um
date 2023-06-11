import 'package:flutter/material.dart';
import 'package:project_um/constants/colors.dart';
import 'package:project_um/screens/secondary%20screens/faculty_screen.dart';
import 'package:project_um/utils/block_image.dart';

import '../notifications_screen.dart';

class InformationScreen extends StatelessWidget {
  InformationScreen({super.key});

  List<List<dynamic>> primaryData = [
    ["2", "Faculty Information", blueSecondaryColor],
    ["1", "Student Board Information", orangeSecondaryColor],
    ["4", "Clubs Information", greenSecondaryColor],
    ["5", "University Information", yellowSecondaryColor],
    ["3", "Academic Calendar", redSecondaryColor],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Information"),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.builder(
            itemCount: primaryData.length,
            itemBuilder: (BuildContext builder, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FacultyScreen()));
                },
                child: BlockImage(
                  imageName: primaryData[index][0],
                  name: primaryData[index][1],
                  colorName: primaryData[index][2],
                ),
              );
            }),
      ),
    );
  }
}
