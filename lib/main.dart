import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_um/authentication/auth_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,
      ),
      home: AuthManager(),
    );
  }
}
