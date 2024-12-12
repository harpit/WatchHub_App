import 'package:flutter/material.dart';
import 'package:watchhub/Pages/Admin/adminhome.dart';
import 'package:watchhub/Pages/UIHelpers/ErrorUi.dart';

class Adminlogin extends StatefulWidget {
  const Adminlogin({super.key});

  @override
  State<Adminlogin> createState() => _AdminloginState();
}

class _AdminloginState extends State<Adminlogin> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      // Handle case where email or password is empty
      showErrorMessage(context, 'An Email and Password cannot be Empty');
      return;
    }
    if (email == "Admin@gmail.com" && password == "Admin123") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Adminhome()));
    } else {
      showErrorMessage(context, 'Invalid Email and Password ');
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
                            "Welcome",
                            style: TextStyle(
                                color: Colors.blueGrey.shade300,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Admin",
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
                      //SizedBox(height: 10),
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
