import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchhub/Pages/Admin/Adminlogin.dart';
import 'package:watchhub/Pages/ContactUs.dart';
import 'package:watchhub/Pages/FAQs.dart';
import 'package:watchhub/Pages/Shippingaddress.dart';
import 'package:watchhub/Pages/Signin.dart';
import 'package:watchhub/Pages/cart.dart';
import 'package:watchhub/Pages/forgetpassword.dart';
import 'package:watchhub/Pages/user_profile.dart'; // Import the UserProfile class

final FirebaseAuth _auth = FirebaseAuth.instance;

Drawer buildDrawer(BuildContext context, UserProfile userProfile) {
  return Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildMenuItems(context, userProfile) // Pass userProfile here
        ],
      ),
    ),
  );
}

Widget buildHeader(BuildContext context) => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              colors: [Colors.blueGrey.shade200, Colors.grey.shade800])),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 52,
            backgroundImage: AssetImage("assets/images/profile.webp"),
          ),
          SizedBox(
            height: 15,
          ),
          FutureBuilder(
            future: fetchRegisteredUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<User> users = snapshot.data ?? [];

                return Column(
                  children: [
                    // Display the user data
                    for (User user in users)
                      ListTile(
                        title: Center(
                          child: Text(
                            user.email ?? 'No Email',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                  ],
                );
              }
            },
          ),
        ],
      ),
    );

Widget buildMenuItems(BuildContext context, UserProfile userProfile) =>
    Container(
      padding: EdgeInsets.all(24),
      child: Wrap(
        children: [
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.blueGrey,
            ),
            title: Text(
              "Profile",
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w600),
            ),
            onTap: () {
              // Navigate to the ProfilePage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShippingAddressPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.home_filled,
              color: Colors.blueGrey,
            ),
            title: Text("Home",
                style: TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.w600)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_bag,
              color: Colors.blueGrey,
            ),
            title: Text("My Carts",
                style: TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.w600)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(productDetails: {}),
                  ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.contact_emergency,
              color: Colors.blueGrey,
            ),
            title: Text("Contact Us",
                style: TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.w600)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactUs(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.contact_support,
              color: Colors.blueGrey,
            ),
            title: Text("FAQs",
                style: TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.w600)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FaqsPage(),
                  ));
            },
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPassword(),
                          ));
                    },
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
                SizedBox(
                  width: 13,
                ),
                Icon(
                  Icons.lock_reset,
                  color: Colors.blueAccent,
                )
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Adminlogin(),
                          ));
                    },
                    child: Text(
                      "Login As Admin",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
                SizedBox(
                  width: 13,
                ),
                Icon(
                  Icons.login,
                  color: Colors.blueGrey,
                )
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signin(),
                          ));
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
                SizedBox(
                  width: 13,
                ),
                Icon(
                  Icons.logout,
                  color: Colors.red,
                )
              ],
            ),
          )
        ],
      ),
    );

Future<List<User>> fetchRegisteredUsers() async {
  List<User> users = [];

  try {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      users.add(currentUser);
    }
  } catch (e) {
    print("Error fetching users: $e");
  }
  return users;
}
