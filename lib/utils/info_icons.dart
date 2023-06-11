import 'package:flutter/material.dart';

class InfoIcons extends StatelessWidget {
  final String imageName;
  final String sectionName;
  InfoIcons({super.key, required this.imageName, required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(child: Image.asset(imageName, height: 80), width: 60),
            Text(
              sectionName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
