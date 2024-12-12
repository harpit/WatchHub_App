import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:watchhub/Pages/Category.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child("contactus");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blueGrey, Colors.grey.shade700],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.020),
            child: Column(
              children: [
                Image.asset('assets/images/contactimage.png'),
                Text(
                  "Contact Us",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: size.height * 0.024,
                ),
                TextFormField(
                  controller: _name,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 25.0),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(32))),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                TextFormField(
                  controller: _email,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(32))),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                TextFormField(
                  controller: _message,
                  maxLines: 10,
                  minLines: 1,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 25.0),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Message",
                      prefixIcon: Icon(Icons.message),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(32))),
                ),
                // SizedBox(height: 20,),
                CupertinoButton(
                  child: Container(
                    padding: EdgeInsets.zero,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: size.height * 0.080,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.shade600,
                          borderRadius: BorderRadius.circular(37)),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Map<String, String> Save = {
                      "name": _name.text,
                      "email": _email.text,
                      "pass": _message.text,
                    };

                    dbRef.push().set(Save);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Category(
                                  tag: 'Omega',
                                  userProfile: userProfile,
                                )));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
