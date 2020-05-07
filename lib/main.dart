import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'item_class.dart';





void main(){
  WidgetsFlutterBinding.ensureInitialized();

  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Todo_Application",
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text("ToDo App"),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          new Icon(Icons.list, color: Colors.white,),
          new Padding(padding: const EdgeInsets.only(right: 12.0))
        ],
      ),
      backgroundColor: Colors.white,
      body: new MainScreen(),
    ),
  ));
}