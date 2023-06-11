import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../authentication/auth.dart';
import '../constants/colors.dart';
import '../utils/header_text.dart';
import '../utils/user_input_util.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  List<String> dropdownItems = ['Student', 'Teacher'];

  late String selectedDropdownItem;

  @override
  void initState() {
    super.initState();
    selectedDropdownItem = dropdownItems[0]; // Set the initial selected item
  }

  @override
  void dispose() {
    _phonenumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpassController.dispose();
    _nameController.dispose();

    _idController.dispose();
    super.dispose();
  }

  Future<void> signup() async {
    try {
      if (passwordConfirmed()) {
        AuthMethods().signUpUser(
          email: _emailController.text,
          password: _passwordController.text,
          phoneNumber: _phonenumberController.text,
          userId: _idController.text,
          name: _nameController.text,
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('  Password Not Matched'),
            );
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password is Week, Choose Stronger one'),
            );
          },
        );
      } else if (e.code == 'email-already-in-use') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                    'Oops ! Account for this email already exits, please LOGIN instead'),
              );
            });
      }
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() == _confirmpassController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),

                HeaderText(givenText: "Create Account"),
                SizedBox(
                  height: 50,
                ),
                Text("Email"),
                UserInputField(
                  userField: _emailController,
                  ispass: false,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Phone number"),
                UserInputField(
                  userField: _phonenumberController,
                  ispass: false,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Student ID/ Teachers ID"),
                UserInputField(
                  userField: _idController,
                  ispass: false,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Create Password"),
                UserInputField(
                  userField: _passwordController,
                  ispass: true,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Confirm Password"),
                UserInputField(
                  userField: _confirmpassController,
                  ispass: true,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration:
                            BoxDecoration(color: textInputBackgroundColor),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedDropdownItem,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedDropdownItem = newValue;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            size: 24.0,
                            textDirection: TextDirection.rtl,
                            semanticLabel: 'Dropdown Icon',
                          ),
                          dropdownColor: textInputBackgroundColor,
                          items: dropdownItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      signup();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(7.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80.0, vertical: 14),
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Expanded(child: Text("")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already a Member?',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        '  Login Instead',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
