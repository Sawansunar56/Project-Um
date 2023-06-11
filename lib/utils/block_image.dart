import 'package:flutter/material.dart';
import 'package:project_um/constants/colors.dart';

class BlockImage extends StatelessWidget {
  String name;
  String imageName;
  Color colorName;
  BlockImage(
      {super.key,
      required this.name,
      required this.imageName,
      required this.colorName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
            color: colorName, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/${imageName}.png",
                    height: 50,
                  ),
                  SizedBox(width: 20),
                  Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
