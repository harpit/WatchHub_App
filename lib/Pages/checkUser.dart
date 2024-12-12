import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchhub/Pages/Category.dart';
import 'package:watchhub/Pages/Signin.dart';

class checkuser extends StatefulWidget {
  const checkuser({super.key});

  @override
  State<checkuser> createState() => _checkuserState();
}

class _checkuserState extends State<checkuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  checkuser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return Category(
        tag: 'Omega',
        userProfile: userProfile,
      );
    } else {
      return Signin();
    }
  }
}
