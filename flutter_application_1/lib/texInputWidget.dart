import 'package:flutter/material.dart';
class TextInputWidget extends StatefulWidget {
  
  final Function(String) callback;
  TextInputWidget(this.callback);
  @override
 _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();
  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }
  void click(){
    widget.callback(controller.text);
    FocusScope.of(context).unfocus();
    controller.clear();
    
  }
  @override
  Widget build(BuildContext context) {
    return  TextField(
        controller:this.controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.message, 
            color: Colors.black,
          ), 
          labelText: "Type Message",
          labelStyle: TextStyle(color:Colors.black), 
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black), // Set non-focused underline color
          ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black), // Set the underline color
            ),
            suffixIcon: IconButton(icon:Icon(Icons.send, color: Colors.black), 
            splashColor: Colors.green,
            tooltip: "Post",
            onPressed: this.click
            )
          ),
        );
    }
  
}