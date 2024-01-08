import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/colors.dart';
import '../../utils/user_input_util.dart';

class ProductAdd extends StatelessWidget {
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productBioController = TextEditingController();
  TextEditingController _productCostController = TextEditingController();
  ProductAdd({super.key});

  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  XFile? image;

  Future<List<String>> getUserDetails() async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection("Teacher");

    final DocumentSnapshot userSnapshot =
        await usersCollection.doc(userId).get();

    final phoneNumber = userSnapshot.get('phoneNumber');
    final name = userSnapshot.get('name');

    return [name, phoneNumber];
  }

  Future<void> addProduct() async {
    String image_url = await uploadImage();
    List<String> userDetails = await getUserDetails();
    await FirebaseFirestore.instance.collection('products').add({
      'userName': userDetails[0],
      'phoneNumber': userDetails[1],
      'productName': _productNameController.text,
      'productCost': _productCostController.text,
      'productDescription': _productBioController.text,
      'userId': userId,
      'productImage': image_url,
    });
  }

  uploadImage() async {
    String image_url = "";
    if (image != null) {
      var imageFile = File(image!.path);

      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref =
          storage.ref().child("Image-" + _productNameController.text);

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
        title: const Text("Add a Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text("Name"),
              UserInputField(
                userField: _productNameController,
                ispass: false,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Description"),
              UserInputField(
                userField: _productBioController,
                ispass: false,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Cost"),
              UserInputField(
                userField: _productCostController,
                ispass: false,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    getImage();
                  },
                  child: Text("pick image")),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: GestureDetector(
                  onTap: () async {
                    if (image == null) {
                      return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Provide the details first"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Ok"))
                                ],
                              ));
                    } else {
                      addProduct();
                    }
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(7.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 75.0, vertical: 14),
                      child: Text(
                        "Add Product",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
