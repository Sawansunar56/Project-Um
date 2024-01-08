import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_um/authentication/auth.dart';
import 'package:project_um/screens/primary%20screens/admin_list.dart';
import 'package:project_um/screens/primary%20screens/teacher_profile.dart';
import 'package:project_um/screens/secondary%20screens/complain_screen.dart';

import '../constants/colors.dart';

class DrawerStuffScreen extends StatelessWidget {
  String userId = FirebaseAuth.instance.currentUser!.uid.toString();
  DrawerStuffScreen({super.key});

  isAdmin() async {
    bool hold = false;
    DocumentSnapshot user =
        await FirebaseFirestore.instance.collection("Admin").doc(userId).get();

    if (user.exists) {
      hold = true;
    }
    return hold;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: primaryColor,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Students Hub",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ComplainScreen()));
            },
            child: Text(
              "Add Complaint",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(child: Text("")),

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: GestureDetector(
              onTap: () async {
                final status = await isAdmin();
                print(status);
                if (status) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AdminList()));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TeacherProfile()));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(7.0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 75.0, vertical: 14),
                  child: Text(
                    "Manage",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: GestureDetector(
              onTap: () {
                AuthMethods().signOut();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(7.0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80.0, vertical: 14),
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
          // Text("hello")
        ],
      ),
    );
  }
}
