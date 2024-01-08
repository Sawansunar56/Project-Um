import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../utils/block_image.dart';

class ClubList extends StatelessWidget {
  const ClubList({super.key});

  Stream<QuerySnapshot> getDataStream() {
    return FirebaseFirestore.instance.collection('products').snapshots();
  }

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
            onTap: () {},
            child: BlockImage(
                name: "Co-Curricular Club",
                imageName: "1",
                colorName: redSecondaryColor),
          ),
          BlockImage(
              name: "Extra-Curricular Club",
              imageName: "3",
              colorName: orangeSecondaryColor),
        ]),
      ),
    );
  }
}
