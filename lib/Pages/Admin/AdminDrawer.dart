import 'package:flutter/material.dart';
import 'package:watchhub/Pages/Admin/ContactFetch.dart';
import 'package:watchhub/Pages/Admin/OrdersHistory.dart';
import 'package:watchhub/Pages/Splash_Screen.dart';

Drawer AdminDrawer(BuildContext context) {
  return Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildMenuItems(context) // Pass userProfile here
        ],
      ),
    ),
  );
}

Widget buildHeader(BuildContext context) => Container(
      //color: Colors.blueGrey.shade400,
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
          Center(
            child: Text("Admin@gmail.com",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70)),
          )
        ],
      ),
    );

Widget buildMenuItems(BuildContext context) => Container(
      padding: EdgeInsets.all(24),
      child: Wrap(
        children: [
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
              Icons.contact_emergency,
              color: Colors.blueGrey,
            ),
            title: Text("FeedBack Record",
                style: TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.w600)),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => record()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.contact_emergency,
              color: Colors.blueGrey,
            ),
            title: Text("Orders Record",
                style: TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.w600)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Orderhistory()));
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
                            builder: (context) => SplashScreen(),
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
