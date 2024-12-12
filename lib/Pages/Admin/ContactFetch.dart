import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class record extends StatefulWidget {
  const record({super.key});

  @override
  State<record> createState() => _recordState();
}

class _recordState extends State<record> {
  final databaserecord = FirebaseDatabase.instance.ref().child("contactus");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FeedBack Record",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
            query: databaserecord,
                itemBuilder: (context, snapshot, animation, index) {
                  return ListTile(
                    title: Text(snapshot.child('name').value.toString(),style: TextStyle(fontSize: 20)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.child('email').value.toString(),style: TextStyle(fontSize: 20),),
                        SizedBox(height: 4),
                        Text(snapshot.child('pass').value.toString(),style: TextStyle(fontSize: 16)), // Message
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        var mykey = snapshot.key;
                        print(mykey.toString());
                        deleteRecord(mykey);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
          ))
        ],
      ),
    );
  }

  deleteRecord(var mykey) async {
    await databaserecord.child(mykey).remove();
  }
}
