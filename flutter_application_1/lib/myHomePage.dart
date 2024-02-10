import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/navigationDrawer.dart';
import 'package:flutter_application_1/user.dart';
import 'post.dart';
import 'postList.dart';
import 'texInputWidget.dart';
import 'currentUser.dart';
class MyHomePage extends StatefulWidget {
  String name = "";
 
  MyHomePage(name){
    this.name = name ?? "";
    
  }

  // MyHomePage(this.name);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
   void initState() {
    
    super.initState();
    // Call your method here
    loadPosts();
  }
  Future<void> loadPosts() async {
    
    posts = await fetchPosts();
    setState(() {});
  
  }
  void newPost(String text)async {
     Post post = new Post(text, widget.name);
    String postId = await savePost(post);
    post.ID = postId; // Set the generated ID in the post
    posts.add(post);

    setState(() {});
  }
  void logout() async {
  await auth.signOut();
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginPage())
  );
  // Additional logic after logout if needed
}
  @override
  Widget build(BuildContext context) {
  return WillPopScope(
    onWillPop: () async => false,
    child: Scaffold(
      key: _scaffoldKey,
      drawer: DrawerComponent(),
      appBar: AppBar(
        
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        title: Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ 
            IconButton(
              onPressed: _openDrawer, 
              icon: Icon(
                Icons.menu,
                color: Colors.white
              )
            ),
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: this.logout,
            )
          ]
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: PostList(this.posts)),
          TextInputWidget(this.newPost), 
        ],
      ),
    ),
  );
}
}