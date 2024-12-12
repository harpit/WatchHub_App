import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchhub/Pages/Category.dart';
import 'package:watchhub/Pages/Signin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _textVisible = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _animation = Tween<double>(
      begin: 1.0,
      end: 25.0,
    ).animate(_animationController);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Call the asynchronous function after the first frame is built
    });
  }

  void navigateToCategoryOrSignin() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is already logged in, navigate to Category page
      print("Navigating to Category page.");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Category(
                  tag: 'Omega',
                  userProfile: userProfile,
                )),
      );
    } else {
      // User is not logged in, navigate to Signin page
      print("Navigating to Signin page.");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Signin()),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/SplashScreen.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [
              Colors.black.withOpacity(.9),
              Colors.black.withOpacity(.8),
              Colors.black.withOpacity(.2),
            ]),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Time Unleashed at",
                  style: TextStyle(
                    fontSize: 60.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "WatchHub",
                  style: TextStyle(
                      fontSize: 60.0,
                      color: Colors.blueGrey.shade400,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Precision and Style,\nAll in One Hubs",
                  style:
                      TextStyle(color: Colors.white, height: 1.5, fontSize: 21),
                ),
                SizedBox(
                  height: 70,
                ),
                ScaleTransition(
                  scale: _animation,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          colors: [Colors.blueGrey, Colors.black]),
                    ),
                    child: AnimatedOpacity(
                      opacity: _textVisible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 50),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        child: TextButton(
                            onPressed: navigateToCategoryOrSignin,
                            child: Text(
                              "Start Exploring",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                        onPressed: navigateToCategoryOrSignin,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                AnimatedOpacity(
                  opacity: _textVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 50),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
