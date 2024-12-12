import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchhub/Pages/Category.dart';
import 'package:watchhub/Pages/Signin.dart';
import 'package:watchhub/Pages/UIHelpers/ErrorUi.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register>
    with SingleTickerProviderStateMixin {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _registerWithEmailAndPassword() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Handle case where email or password is empty
      showErrorMessage(context, 'Email and Password Cannot be Empty');
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Registration successful, navigate to Home Page
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Category(
                    tag: 'Omega',
                    userProfile: userProfile,
                  )));
    } catch (e) {
      // Handle registration errors
      showErrorMessage(context, 'An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomScrollView(slivers: [
            SliverAppBar(
              expandedHeight: 400,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Sign.webp'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.bottomCenter, stops: [
                        0.4,
                        0.8
                      ], colors: [
                        Colors.black.withOpacity(.8),
                        Colors.black.withOpacity(.3),
                      ]),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 270),
                      child: Align(
                          child: Text(
                        "Register Now",
                        style: TextStyle(
                            color: Colors.blueGrey.shade300,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          controller: _nameController,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.blueGrey,
                            ),
                            hintText: "Name",
                            hintStyle:
                                TextStyle(color: Colors.blueGrey, fontSize: 20),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          controller: _emailController,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.blueGrey,
                            ),
                            hintText: "Email",
                            hintStyle:
                                TextStyle(color: Colors.blueGrey, fontSize: 20),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          controller: _passwordController,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          obscureText: true,
                          obscuringCharacter: '*',
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.blueGrey,
                            ),
                            hintText: "Password",
                            hintStyle:
                                TextStyle(color: Colors.blueGrey, fontSize: 20),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 27,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Already Have an Account?",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Signin(),
                                  ));
                            },
                            child: Text("SignIn",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: LinearGradient(colors: [
                              Colors.blueGrey.withOpacity(.5),
                              Colors.black
                            ]),
                          ),
                          child: Align(
                              child: TextButton(
                                  onPressed: _registerWithEmailAndPassword,
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
