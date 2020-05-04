import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:todo_application_test/item_class.dart';

class DatabaseHelper {
  String itemName = 'item_name';
  String itemTable = 'item_table';
  String dateCreated = 'date_created';
  String itemId = 'id';

  DatabaseHelper.instance();
  static final DatabaseHelper dataDB = new DatabaseHelper.instance();
  factory DatabaseHelper()=>dataDB;

  static Database _db;

  Future<Database> get db async{
    if(_db != null){
      return _db;
    } _db = await initDB();
    return _db;
  }

  initDB() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "newDatabase.db");
    var ourDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDB;
}


   _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $itemTable($itemId INTEGER PRIMARY KEY, $itemName TEXT, $dateCreated TEXT)'
    );
  }


  //CRUD -- CREATE, READ, UPDATE, DELETE

//CREATE USER
Future<int> createUser(String itemName) async{
    Item newItem = new Item(itemName);
    var dbClient = await db;
    return await dbClient.insert(itemTable, newItem.toMap());
}

//READ ALL USERS
Future<List> getAllUsers() async {
    var dbClient = await db;
    return await dbClient.rawQuery(
      'SELECT * FROM $itemTable'
    );
}

//READ ONE USER
Future<Item> getOneUser(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
      'SELECT * FROM $itemTable WHERE $itemId = $id'
    );
    return Item.fromMap(result.first);
}

//UPDATE USER
Future<int> updateUser(String itemName, int id) async {
    Item newItem = new Item(itemName);
    var dbClient = await db;
    return await dbClient.update(itemTable, newItem.toMap(), where: '$itemId = ?', whereArgs: [id]);
}

//DELETE USER
Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient.delete(itemTable, where: '$itemId = ?', whereArgs: [id]);
}

//CLOSE DATABASE
Future closeDatabase() async {
    var dbClient = await db;
    return await dbClient.close();
}

//COUNT ALL ROWS IN TABLE
Future<int> countUsers() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
      'COUNT * FROM $itemTable'
    ));
}


}