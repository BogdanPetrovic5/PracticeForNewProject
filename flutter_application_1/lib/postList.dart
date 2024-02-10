import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/currentUser.dart';
import 'package:flutter_application_1/database.dart';
import 'post.dart';
class PostList extends StatefulWidget {
  final List<Post> ListItems;
  PostList(this.ListItems);
 @override
 _PostList createState() => _PostList();
}

class _PostList extends State<PostList> {
  bool isLiked(Post post){
    
     FirebaseAuth _auth = FirebaseAuth.instance;

    String currUser = _auth.currentUser!.uid;
    int index = post.uidList.indexOf(currUser);
    if(index != -1){
      
      return true;

    }else{
      return false;
    }
    
  }
  void like(String id){
    

   
      FirebaseAuth _auth = FirebaseAuth.instance;

    String currUser = _auth.currentUser!.uid;
    Post post;
    print(currUser);
    for(int i = 0; i < widget.ListItems.length; i++){
      if(widget.ListItems[i].ID == id){
        post = widget.ListItems[i];
        if(widget.ListItems[i].uidList.indexOf(currUser) != -1){
           widget.ListItems[i].uidList.remove(currUser);
           widget.ListItems[i].likes -= 1;
        }else {
          widget.ListItems[i].uidList.add(currUser);
          widget.ListItems[i].likes += 1;
        }
       
        updateDatabaseSinglePost(id, post);
        break;
      }
    }
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: this.widget.ListItems.length, 
      itemBuilder: (context, index) {
        var post = this.widget.ListItems[index];
        return Card(
          child: Row(children: <Widget>[
            Expanded(
              child: ListTile(title: Text(post.body), 
              subtitle: Text(post.author),)), 
              Row(children: <Widget>[
                Container(
                  child:
                    Text(post.likes.toString(), style: TextStyle(fontSize: 20),),
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                ),
                IconButton(
                  icon:Icon(
                    Icons.thumb_up,
                    color: isLiked(post) ? Colors.red : Colors.grey,
                  ),
                  onPressed:() => like(post.ID),
                 
                )
            ])
          ],
          )
        );
      },
    );
  }
}