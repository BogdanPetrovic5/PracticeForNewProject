import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/userProvider.dart';

import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'myHomePage.dart';
import 'login.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: MaterialApp(
      title: 'Moja nova app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black, 
          // Set the default background color for AppBar
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: LoginPage(),
    ),
  );
}

}






