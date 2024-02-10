// ignore_for_file: unnecessary_this

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/myHomePage.dart';

class Settings extends StatelessWidget {
  final usernameController = TextEditingController();
  
   void changeUsername(String username, BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    String currUserID = _auth.currentUser!.uid;

    DatabaseReference _ref = FirebaseDatabase.instance.ref().child('users').child(currUserID);

    _ref.update({'username': username}).then((_){
        showSuccessSnackbar(context);
        print("Changed usernamed");
        
    }).catchError((error){
      print(error);
    });

  }
  void showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Username changed succesfully'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            // Action to be performed when "Dismiss" is pressed.
          },
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Align(
        alignment: Alignment.bottomCenter,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle_sharp,
              color: Colors.red,
              size: 150,
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              
              width: 300, 
              child: TextField(
                controller: this.usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_2,
                    color: Colors.red,
                    size:30
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red
                      ), // Set the underline color
                  ),
                  enabledBorder:  UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red
                    ), // Set non-focused underline color
                  ),
                  labelText: "New Username",
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.check
                    ),
                    color: Colors.red,
                    onPressed: () {
                      changeUsername(usernameController.text, context);
                    },
                  )
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 300, 
              child: TextField(
                
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.key,
                    color: Colors.red,
                    size:30
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red
                      ), // Set the underline color
                  ),
                  enabledBorder:  UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red
                    ), // Set non-focused underline color
                  ),
                  labelText: "New Password",
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  suffixIcon: Icon(
                    Icons.check,
                    color: Colors.red,
                  ),

                ),
              ),
            )
            
          ],
        )
      ),
    );
  }
}