import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/myHomePage.dart';
import 'package:flutter_application_1/user.dart';
import 'post.dart';
final databaseReference = FirebaseDatabase.instance.ref();
List<Post> posts  = [];
Future<List<Post>> fetchPosts() async{
  DataSnapshot snapshot = await databaseReference.child('posts/').get();
  if(snapshot.value != null){
    Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;
    posts.clear();
    if(values != null){
      values.forEach((key, value) {
        Map<String, dynamic> postMap = Map<String, dynamic>.from(value);
        Post post = new Post(postMap['body'], postMap['author']);
        post.ID = key;
        post.likes = postMap['likes'];
        post.uidList = postMap['uidList'] != null ? List<String>.from(postMap['uidList']) : [];
        posts.add(post);
      });
    }
  }
  return posts;

}
void updateDatabaseSinglePost(String postID, Post post){
  DatabaseReference postsRef = FirebaseDatabase.instance.ref().child('posts');
  DatabaseReference postToUpdate = postsRef.child(postID);
  postToUpdate.update({
    
    'author': post.author,
    'body':post.body,
    'likes':post.likes,
    'uidList':post.uidList

  }).then((value) {
    print("Post updated");
  }).catchError((error){
    print(error);
  });
}
Future<String> savePost(Post post) async {
  DatabaseReference postsRef = FirebaseDatabase.instance.ref().child('posts');
  var id = postsRef.push();

  await id.set({
    'body': post.body,
    'author': post.author,
    'likes': post.likes,
    'uidList': post.uidList,
  });

  return id.key!; // Return the generated ID
}
DatabaseReference saveUser(User user){
  var id = databaseReference.child('users/').push();
  id.set(user.username);
  
  return id;
}