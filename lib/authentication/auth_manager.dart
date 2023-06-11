import 'package:flutter/material.dart';
import 'package:project_um/authentication/auth.dart';
import 'package:project_um/home.dart';
import 'auth_Page.dart';

class AuthManager extends StatefulWidget {
  static const routeName = '/authManager';
  const AuthManager({Key? key}) : super(key: key);

  @override
  State<AuthManager> createState() => _AuthManagerState();
}

class _AuthManagerState extends State<AuthManager> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthMethods().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return const AuthPage();
        }
      },
    );
  }
}
