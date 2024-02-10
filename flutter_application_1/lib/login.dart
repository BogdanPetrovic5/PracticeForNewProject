

import 'dart:ffi';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/register.dart';
import 'package:flutter_application_1/userProvider.dart';

import 'currentUser.dart';
import 'myHomePage.dart';
import 'package:provider/provider.dart';
import 'currentUser.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Login!",
          style: TextStyle(
            fontSize:20,
            color: Colors.white,
           
          ),
        )
        
        
      ),
      body: Body(

      ),
    );
  }
}
class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body>  {
  String name = "";
  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  bool obscureText = true;
  FirebaseAuth _auth = FirebaseAuth.instance;
  
  
  Future<String?> getUsernameByUID(String uid) async {
    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('users');

    try {
      DatabaseEvent event = await usersRef.child(uid).once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {

        Map<String, dynamic>? userData = _convertToMap(snapshot.value);

        if (userData != null) {
          String username = userData['username'] ?? '';
          print("USERNAME: ${username}");
          return username;
        } else {

          
          return null;
        }
      } else {
      
        
        return null;
      }
    } catch (error) {
    
      print('Error querying database: $error');
      return null;
    }
}
Map<String, dynamic>? _convertToMap(dynamic value) {
  // Explicitly convert 'value' to Map<String, dynamic> or return null
  if (value is Map<Object?, Object?>) {
    Map<String, dynamic> convertedMap = {};
    value.forEach((key, value) {
      if (key is String) {
        convertedMap[key] = value;
      }
    });
    return convertedMap;
  } else {
    return null;
  }
}
  Future<void> signin(BuildContext context) async{
    CurrentUser? currentUser;
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: controllerUsername.text.trim(),
        password: controllerPassword.text.trim()
      );
      User? user = userCredential.user;
      String userUID = user?.uid ?? '';
      
      
      String? username = await getUsernameByUID(userUID);
       UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
  

      showSuccessSnackbar(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(username))
      );
      
    }catch(e){
      print("Error signing in: $e");
    }
  }
 

  bool userExist(){
    final databaseReference = FirebaseDatabase.instance.ref();
    Query userRef = databaseReference.child('users/').orderByValue().equalTo(controllerUsername.text);
    
    return false;
  }
  void changeToRegistration(){
      Navigator.push(
        context,
        PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
              reverseCurve: Curves.easeInOut,
            ),
          ),
            child: RegisterPage(),
          ),
        ),
      );
  }
  void showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login Successful'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            
          },
        ),
      ),
    );
  }
  @override

  Widget build(BuildContext context) {

    return Container(
      color: Colors.black,
      child: Align(
        alignment:Alignment.topCenter,
        child: Padding(
          
          padding: EdgeInsets.all(10),
          child: Column(
              
              mainAxisSize: MainAxisSize.min,
              children: [
                
                TextField(
                    controller: this.controllerUsername,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail, color: Colors.white,
                        ), 
                      labelText: "Type email",
                      labelStyle: TextStyle(
                        color:Colors.white
                      ), 
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white
                        ), // Set non-focused underline color
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white
                          ), // Set the underline color
                      ),
                    ),
                     style: TextStyle(
                    color:Colors.white
                  ),
                  ),
                  SizedBox(
                    height: 16
                  ),
                  TextField(
                    controller: this.controllerPassword,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_rounded, color: Colors.white,
                        ), 
                      labelText: "Type password",
                      labelStyle: TextStyle(
                        color:Colors.white
                      ), 
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white
                        ), // Set non-focused underline color
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white
                          ), // Set the underline color
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.visibility,
                          color: Colors.white,
                          ),
                        onPressed: () {
                        // Toggle password visibility
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                      
                    ),
                     style: TextStyle(
                    color:Colors.white
                  ),
                  ),
                  SizedBox(
                    height: 16
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: MediaQuery.of(context).size.width * 0.9, 
                      height: 40
                    ), // Set the minimum width and height
                    child: TextButton(
                      onPressed: () {
                        
                          signin(context);
                       
                      },
                      style: TextButton.styleFrom(
                        primary: const Color.fromARGB(255, 0, 0, 0), // Set the text color
                        backgroundColor: Colors.white, // Set the button background color
                      ),
                      child: Text('Login!'),
                    ),
                  ),
                  SizedBox(
                    height: 16
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: MediaQuery.of(context).size.width * 0.9, 
                      height: 40
                    ), // Set the minimum width and height
                    child: TextButton(
                      onPressed: () {
                        changeToRegistration();
                      },
                      style: TextButton.styleFrom(
                        primary: const Color.fromARGB(255, 0, 0, 0), // Set the text color
                        backgroundColor: Colors.white, // Set the button background color
                      ),
                      child: Text("Don't have an account? Register here!"),
                    ),
                  )
                
              ]
            )
                    
          ),
          
        )
    );

    
      
    
  }
}