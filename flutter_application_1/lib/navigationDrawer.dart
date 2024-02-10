import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/HelperFunctions/getUsername.dart';
import 'package:flutter_application_1/settings.dart';

class DrawerComponent extends StatefulWidget {
  @override
  _DrawerComponentState createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  late Future<String> _usernameFuture;

  @override
  void initState() {
    super.initState();
    _usernameFuture = getUsername();
  }
  Future<String> getUsername() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = _auth.currentUser!.uid;
    // Assuming getUsernameByUID returns a Future<String>
    return await getUsernameByUID(uid) ?? 'Default Username'; // Provide a default username if null
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            child: FutureBuilder<String>(
              future: _usernameFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final username = snapshot.data;
                  return Text(
                    'Welcome $username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  );
                }
              },
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              // Handle the tap on Home
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: Text('Liked Posts'),
            onTap: () {
              // Handle the tap on Liked Posts
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              // Handle the tap on Settings
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              ); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
