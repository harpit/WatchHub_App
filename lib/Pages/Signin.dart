import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchhub/Pages/Category.dart';
import 'package:watchhub/Pages/Register.dart';
import 'package:watchhub/Pages/UIHelpers/ErrorUi.dart';
import 'package:watchhub/Pages/forgetpassword.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showErrorMessage(context, 'Email and Password Cannot be Empty');
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Sign-in successful, navigate to Home Page
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Category(
                    tag: 'Omega',
                    userProfile: userProfile,
                  )));
    } catch (e) {
      // Handle sign-in errors
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
                      margin: EdgeInsets.only(top: 300),
                      child: Column(
                        children: [
                          Text(
                            "Welcome Back",
                            style: TextStyle(
                                color: Colors.blueGrey.shade300,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "To WatchHub",
                            style: TextStyle(
                                color: Colors.blueGrey.shade300,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
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
                          obscureText: true,
                          obscuringCharacter: '*',
                          style: TextStyle(color: Colors.white, fontSize: 20),
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
                            "Create Account?",
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Register(),
                                    ));
                                //_signInWithEmailAndPassword(email, password);
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 17.0),
                              ))
                        ],
                      ),
                      Align(
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgetPassword(),
                                  ));
                            },
                            child: Text(
                              "Forget Password",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16.0),
                            )),
                      ),
                      SizedBox(height: 15),
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
                                  onPressed: _signInWithEmailAndPassword,
                                  child: Text(
                                    "Login",
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
