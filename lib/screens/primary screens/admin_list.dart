import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_um/screens/primary%20screens/admin_student.dart';

import '../notifications_screen.dart';

class AdminList extends StatelessWidget {
  const AdminList({super.key});

  Stream<QuerySnapshot> getDataStream() {
    return FirebaseFirestore.instance.collection('Student').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Admin Controls"),
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
        child: StreamBuilder(
          stream: getDataStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final Students = snapshot.data!.docs;

            return ListView.builder(
              itemCount: Students.length,
              itemBuilder: (context, index) {
                final Student = Students[index].data() as Map<String, dynamic>;
                final StudentId = Students[index].reference.id;
                return GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 2,
                    shadowColor: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            Student["name"],
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // title: Text("${product['productName']}"),
                  // subtitle: Text("${product['productDescription']}"),
                  // trailing: Text('${product['productCost']}'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => AdminStudent(
                              userData: Student,
                              userId: StudentId,
                            )),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
