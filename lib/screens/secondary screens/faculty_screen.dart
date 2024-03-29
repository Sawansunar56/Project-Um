import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../notifications_screen.dart';

class FacultyScreen extends StatelessWidget {
  const FacultyScreen({super.key});

  Stream<QuerySnapshot> getDataStream() {
    return FirebaseFirestore.instance.collection('Teacher').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Faculty Information"),
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
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
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

            final teachers = snapshot.data!.docs;

            return ListView.builder(
              itemCount: teachers.length,
              itemBuilder: (context, index) {
                final teacher = teachers[index].data() as Map<String, dynamic>;
                final teacherId = teachers[index].reference.id;
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
                            teacher["name"],
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
                    // navigate to product details page
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: ((context) => ProductDetailsPage(
                    //         product: product, productId: productId)),
                    //   ),
                    // );
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
