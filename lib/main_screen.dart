import 'package:flutter/material.dart';
import 'database_helper_class.dart';
import 'item_class.dart';

//VARIABLES
var database = new DatabaseHelper();
List<Item> items = <Item>[];


//STATEFULL WIDGET MAINSCREEN CLASS
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    loadDatabase();
    super.initState();
  }

  //FLOATING ACTION BUTTON FUNCTIONS
  final TextEditingController floatingController = new TextEditingController();
  void showDialogueFloat(){
    var alert = new AlertDialog(
      content: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Expanded(child: new TextField(
                  controller: floatingController,
                  decoration: new InputDecoration(
                      labelText: 'Enter Item',
                      hintText: 'enter your stuff',
                      icon: new Icon(Icons.note_add, color: Colors.orange,)
                  ),
                ))
              ],
            ),
      actions: <Widget>[
        new FlatButton(
            onPressed: (){
              addToDatabase(floatingController.text);
              Navigator.pop(context);
            },
            child: new Text("Save")),
        new FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: new Text("Cancel"))
      ],
    );
    showDialog(context: context , builder: (_) => alert);
  }
  void addToDatabase(String text) async {
    int createNewUser = await database.createUser(floatingController.text);
    Item itemListNewItem = await database.getOneUser(createNewUser);
    setState(() {
      items.insert(0, itemListNewItem);
    });
  }

//LOAD DATABASE ONTO SCREEN
  void loadDatabase() async{
    List allItems = await database.getAllUsers();
    for(int i = 0; i < allItems.length; i++){
      Item newItem = Item.fromMap(allItems[i]);
      setState(() {
        items.add(newItem);
      });
    }
  }
  
  //DELETE USER FUNCTION
  void deleteItem(int id, int index) async {
      await database.deleteUser(id);
      setState(() {
        items.removeAt(index);
      });
  }




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            new Flexible(
                child: new ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, int indexValue){
                      return new Card(
                        color: Colors.black38,
                        child: new ListTile(
                          title: items[indexValue],
                          trailing: new Listener(
                            key: new Key(items[indexValue].itemName),
                            child: new Icon(Icons.remove_circle, color: Colors.orange,),
                            onPointerDown: (pointerDown) {
                              deleteItem(items[indexValue].id, indexValue);
                            },
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.orange,
          child: new Icon(Icons.add, color: Colors.white,),
          onPressed: () => showDialogueFloat()),
    );
  }
}
