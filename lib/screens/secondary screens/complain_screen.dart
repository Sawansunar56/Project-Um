import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class ComplainScreen extends StatelessWidget {
  ComplainScreen({super.key});

  TextEditingController _complainController = TextEditingController();

  addComplaint() async {
    await FirebaseFirestore.instance.collection("complaint").add({
      "content": _complainController.text,
    });
    _complainController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Add a complaint"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Complaint",
              style: TextStyle(fontSize: 21),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 10,
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 12.0),
                  fillColor: textInputBackgroundColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0.0, style: BorderStyle.none),
                      borderRadius: BorderRadius.circular(8.0))),
              controller: _complainController,
            ),
            Expanded(child: Text("")),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    addComplaint();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(7.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80.0, vertical: 14),
                      child: Text(
                        "Send",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
