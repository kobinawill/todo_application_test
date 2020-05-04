import 'package:flutter/material.dart';
import 'package:todo_application_test/the_date.dart';
import 'the_date.dart';

class Item extends StatelessWidget {
  String itemName;
  String dateCreated = theDate();
  int id;

  Item(this.itemName);

  Map<String, dynamic> toMap(){
    Map map = Map<String, dynamic>();
    map['item_name'] = this.itemName;
    map['date_created'] = this.dateCreated;
    if(id != null){
      map['id'] = this.id;
    }
    return map;
  }

  Item.fromMap(Map<String, dynamic> map){
    this.itemName = map['item_name'];
    this.dateCreated = map['date_created'];
    this.id = map['id'];
  }






  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(8.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(itemName, style: itemNameStyle(),),
          new Text("Created on $dateCreated", style: dateCreatedStyle(),)
        ],
      ),
    );
  }
}


TextStyle itemNameStyle() {
  return new TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 16
  );
}

TextStyle dateCreatedStyle() {
  return new TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w100,
    fontSize: 13
  );
}
