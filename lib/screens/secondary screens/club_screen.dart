import 'package:flutter/material.dart';
import 'package:project_um/constants/colors.dart';
import 'package:project_um/utils/block_image.dart';

class ClubScreen extends StatelessWidget {
  const ClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Club Information"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        child: Column(children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ClubExtraScreen(
                        isTrue: true,
                      )));
            },
            child: BlockImage(
                name: "Co-Curricular Club",
                imageName: "1",
                colorName: redSecondaryColor),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ClubExtraScreen(
                        isTrue: false,
                      )));
            },
            child: BlockImage(
                name: "Extra-Curricular Club",
                imageName: "3",
                colorName: orangeSecondaryColor),
          ),
        ]),
      ),
    );
  }
}

class ClubExtraScreen extends StatelessWidget {
  ClubExtraScreen({super.key, required this.isTrue});

  bool isTrue;
  final List<List<String>> _list = [
    [
      "web designing club",
      "robotics club",
      "coding club",
      "basic science club",
      "cyber security club",
      "Iot club",
      "mechanical club",
      "electrical club",
      "Civil club",
      "Basic science club",
    ],
    [
      "Indoor club",
      "outdoor club",
      "art and craft club",
      "debate and quiz club",
      "photography club",
      "literature club",
      "drama club",
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Club Information"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        child: ListView.builder(
          itemCount: isTrue ? _list[0].length : _list[1].length,
          itemBuilder: (context, index) {
            return isTrue
                ? BlockImage(
                    name: _list[0][index],
                    imageName: "1",
                    colorName: orangeSecondaryColor)
                : BlockImage(
                    name: _list[1][index],
                    imageName: "2",
                    colorName: blueSecondaryColor);
          },
        ),
      ),
    );
  }
}
