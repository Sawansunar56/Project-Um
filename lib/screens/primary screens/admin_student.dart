import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_um/utils/user_input_util.dart';

import '../../constants/colors.dart';
import '../notifications_screen.dart';

class AdminStudent extends StatefulWidget {
  Map<String, dynamic> userData;
  String userId;
  AdminStudent({super.key, required this.userData, required this.userId});

  @override
  State<AdminStudent> createState() => _AdminStudentState();
}

class _AdminStudentState extends State<AdminStudent> {
  TextEditingController _roleController = TextEditingController();
  List<String> dropdownItems = [
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
    "Indoor club",
    "outdoor club",
    "art and craft club",
    "debate and quiz club",
    "photography club",
    "literature club",
    "drama club",
  ];

  late String selectedDropdownItem;
  late String selectedRoleItem;

  roleGiver() async {
    await FirebaseFirestore.instance
        .collection("Student")
        .doc(widget.userId)
        .update({"role": _roleController.text, "club": selectedDropdownItem});
  }

  deleteUser() async {
    await FirebaseFirestore.instance
        .collection("Student")
        .doc(widget.userId)
        .delete();
  }

  @override
  void initState() {
    super.initState();
    selectedDropdownItem = dropdownItems[0]; // Set the initial selected item
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Give Role"),
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
            Text(
              widget.userData["name"],
              style: TextStyle(fontSize: 21),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.userData["userId"],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.userData["phoneNumber"],
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(
              height: 10,
            ),
            Text("What is the Role?"),
            SizedBox(
              height: 10,
            ),
            // TextField(
            //   keyboardType: TextInputType.multiline,
            //   minLines: 1,
            //   maxLines: 10,
            //   decoration: InputDecoration(
            //       isDense: true,
            //       contentPadding: const EdgeInsets.symmetric(
            //           horizontal: 15.0, vertical: 12.0),
            //       fillColor: textInputBackgroundColor,
            //       filled: true,
            //       border: OutlineInputBorder(
            //           borderSide:
            //               BorderSide(width: 0.0, style: BorderStyle.none),
            //           borderRadius: BorderRadius.circular(8.0))),
            // ),

            UserInputField(userField: _roleController, ispass: false),
            SizedBox(
              height: 10,
            ),
            DropdownButton<String>(
              value: selectedDropdownItem,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedDropdownItem = newValue;
                  });
                }
              },
              items:
                  dropdownItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: Text("")),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    roleGiver();
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
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    deleteUser();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(7.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80.0, vertical: 14),
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
