

import 'dart:ffi';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/user.dart';
import 'myHomePage.dart';
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Register!",
          style: TextStyle(
            fontSize:20,
            color: Colors.white,
           
          ),
        )
        
        
      ),
      body: const Body(

      ),
    );
  }
}
class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String name = "";
  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
   TextEditingController controllerEmail = new TextEditingController();
  bool obscureText = true;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(BuildContext context)async{
    try{
      
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: controllerEmail.text.trim(),
        password: controllerPassword.text.trim()
      );
      String uid = userCredential.user?.uid ?? "default_uid";
        await FirebaseDatabase.instance.ref().child('users').child(uid).set({
        'username': controllerUsername.text.trim(),
      
      // Add any other fields you want to store
      });
      showSuccessSnackbar(context);
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage())
      );
    }catch(e){
      print("Error registering in: $e");
    }
  }

  bool userExist(){
    final databaseReference = FirebaseDatabase.instance.ref();
    Query userRef = databaseReference.child('users/').orderByValue().equalTo(controllerUsername.text);
    
    return false;
  }
  void changeToLogin() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage())
      );
  }
  void showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Registration Successful'),
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
    return Container(
      color: Colors.black,
      child: Align(
      
      alignment:Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
            
            mainAxisSize: MainAxisSize.min,
            children: [
             
              const SizedBox(
                height: 16
              ),
              TextField(
                  controller: this.controllerUsername,
                  decoration: const InputDecoration(
                    
                    prefixIcon: Icon(
                      Icons.person, color: Colors.white,
                      ), 
                    labelText: "Type username",
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
                  style: const TextStyle(
                    color:Colors.white
                  ),
                ),
                const SizedBox(
                  height: 16
                ),
                TextField(
                  controller: this.controllerPassword,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_rounded, color: Colors.white,
                      ), 
                    labelText: "Type password",
                    labelStyle: const TextStyle(
                      color:Colors.white
                    ), 
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                      ), // Set non-focused underline color
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                        ), // Set the underline color
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
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
                   style: const TextStyle(
                    color:Colors.white
                  ),
                ),
                TextField(
                  controller: this.controllerEmail,
                 
                  decoration: const InputDecoration(
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
                   style: const TextStyle(
                    color:Colors.white
                  ),
                ),
                const SizedBox(
                  height: 16
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width * 0.9, 
                    height: 40
                  ), // Set the minimum width and height
                  child: TextButton(
                    onPressed: () {
                      register(context);
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.black, // Set the text color
                      backgroundColor: Colors.white, // Set the button background color
                    ),
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(
                  height: 16
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width * 0.9, 
                    height: 40
                  ), // Set the minimum width and height
                  child: TextButton(
                    onPressed: () {
                      changeToLogin();
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.black, // Set the text color
                      backgroundColor: Colors.white, // Set the button background color
                    ),
                    child: const Text('Already have an account? Login here!'),
                  ),
                )
              
            ]
          )
                  
        ),
        
      ),
    );
      
    
  }
}

