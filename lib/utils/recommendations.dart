import 'package:flutter/material.dart';

class Recommendations extends StatelessWidget {
  Map<String, dynamic> product;
  Recommendations({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.network(
              product["productImage"],
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    product["productName"],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    product["productCost"],
                    overflow: TextOverflow.ellipsis,
                  ),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
