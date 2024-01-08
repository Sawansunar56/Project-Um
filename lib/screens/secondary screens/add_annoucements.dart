import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../notifications_screen.dart';

class AddAnnouncements extends StatelessWidget {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  AddAnnouncements({super.key});

  addMessage() async {
    await FirebaseFirestore.instance.collection("message").add({
      "title": _titleController.text,
      "content": _contentController.text,
    });
    _titleController.clear();
    _contentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Add Annoucements"),
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
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 10,
              decoration: InputDecoration(
                  hintText: "Title",
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 12.0),
                  fillColor: textInputBackgroundColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0.0, style: BorderStyle.none),
                      borderRadius: BorderRadius.circular(8.0))),
              controller: _titleController,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 15,
              decoration: InputDecoration(
                  hintText: "Content",
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 12.0),
                  fillColor: textInputBackgroundColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0.0, style: BorderStyle.none),
                      borderRadius: BorderRadius.circular(8.0))),
              controller: _contentController,
            ),
            Expanded(child: Text("")),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    if (_titleController.text.trimRight() != "" &&
                        _contentController.text.trimRight() != "") {
                      addMessage();
                    }
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
