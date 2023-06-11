import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  String title;
  NextPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              print(title);
            },
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Icon(Icons.arrow_forward_outlined)
        ],
      ),
    );
  }
}
