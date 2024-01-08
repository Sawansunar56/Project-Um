import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_um/screens/secondary%20screens/product_add.dart';
import 'package:project_um/utils/recommendations.dart';

import '../../constants/colors.dart';

class BuySellScreen extends StatelessWidget {
  BuySellScreen({super.key});

  String curUserId = FirebaseAuth.instance.currentUser!.uid.toString();
  Stream<QuerySnapshot> getDataStream() {
    return FirebaseFirestore.instance
        .collection('products')
        .where("userId", isEqualTo: curUserId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: getDataStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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

                final products = snapshot.data!.docs;

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 220,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product =
                        products[index].data() as Map<String, dynamic>;
                    final productId = products[index].reference.id;
                    return GestureDetector(
                      child: Recommendations(product: product),
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
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProductAdd()));
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
    );
  }
}
