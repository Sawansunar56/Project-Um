import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_um/utils/user_input_util.dart';

import '../notifications_screen.dart';

class TeacherProfile extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TeacherProfile({super.key});

  XFile? image;

  String userId = FirebaseAuth.instance.currentUser!.uid.toString();

  Future<void> addProduct() async {
    String image_url = await uploadImage();
    await FirebaseFirestore.instance.collection('Teacher').doc(userId).update({
      'name': _nameController.text,
      'profileImage': image_url,
    });
  }

  uploadImage() async {
    String image_url = "";
    if (image != null) {
      var imageFile = File(image!.path);

      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("Image-" + _nameController.text);

      UploadTask uploadTask = ref.putFile(imageFile);
      await uploadTask.whenComplete(() async {
        var url = await ref.getDownloadURL();
        image_url = url.toString();
      }).catchError((onError) {
        print(onError);
      });
    }
    return image_url;
  }

  getImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Profile"),
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
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text("Profile Image"),
                SizedBox(
                  height: 10,
                ),
                UserInputField(userField: _nameController, ispass: false),
                ElevatedButton(
                  onPressed: () {
                    getImage();
                  },
                  child: Text("pick image"),
                ),
              ],
            ),
          )),
    );
  }
}
