import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:watchhub/Pages/UIHelpers/ErrorUi.dart';

class resetPassword extends StatefulWidget {
  const resetPassword({super.key});

  @override
  State<resetPassword> createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();

  Future<void> _resetPassword(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully, notify the user
      // You can display a success message or navigate to a confirmation screen
    } catch (e) {
      // Handle password reset errors, e.g., display an error message
      showErrorMessage(context, 'An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _resetPassword(context, _emailController.text.trim());
            },
            child: Text("Forget Password",
                style: TextStyle(fontSize: 16, color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
