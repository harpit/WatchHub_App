import 'package:flutter/material.dart';
import 'package:watchhub/Pages/Admin/AdminDrawer.dart';
import 'package:watchhub/Pages/ProductPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Adminhome extends StatefulWidget {
  const Adminhome({super.key});

  @override
  State<Adminhome> createState() => _AdminhomeState();
}

class _AdminhomeState extends State<Adminhome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Admin Panel",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        drawer: AdminDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "All",
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Category(
                              Image: 'assets/images/c1.jpg',
                              Title: 'Omega',
                              tag: 'Omega'),
                          Category(
                              Image: 'assets/images/c2.jpg',
                              Title: 'Breiting',
                              tag: 'Breiting'),
                          Category(
                              Image: 'assets/images/c3.jpg',
                              Title: 'Parenai ',
                              tag: 'Parenai'),
                          Category(
                              Image: 'assets/images/c4.jpg',
                              Title: 'Tudor',
                              tag: 'Tudor'),
                          Category(
                              Image: 'assets/images/c5.webp',
                              Title: 'Tag Heuer',
                              tag: 'Tag Heuer'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Active Users",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "All",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        FutureBuilder(
                          future: fetchRegisteredUsers(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              List<User> users = snapshot.data ?? [];

                              return Column(
                                children: [
                                  for (User user in users)
                                    ListTile(
                                      title: Text(user.email ?? 'No Email',
                                          style: TextStyle(fontSize: 20)),
                                      subtitle: Text(user.uid,
                                          style: TextStyle(fontSize: 16)),
                                      trailing: Text("New",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.green)),
                                    ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<List<User>> fetchRegisteredUsers() async {
    List<User> users = [];

    try {
      // Use currentUser to get the currently signed-in user
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        users.add(currentUser);
      }
    } catch (e) {
      print("Error fetching users: $e");
    }

    return users;
  }

  Widget Category({Image, Title, tag}) {
    return AspectRatio(
      aspectRatio: 4 / 2,
      child: Hero(
        tag: tag,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Productshop(Image: Image, Title: Title, tag: tag),
                ));
          },
          child: Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(Image), fit: BoxFit.cover)),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.0)
                ]),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    Title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
