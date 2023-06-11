import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Notifications"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add_alert_rounded))
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
