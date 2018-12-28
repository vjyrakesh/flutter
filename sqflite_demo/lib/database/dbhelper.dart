import 'dart:async';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_demo/model/item.dart';
import 'package:flutter/services.dart' show rootBundle;

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "working_copy.db");
    ByteData data = await rootBundle.load(join("assets", "shopping.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new io.File(path).writeAsBytes(bytes);
    var theDb = await openDatabase(path);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("create table items(item_id integer primary key autoincrement, item_name varchar(30))");
    await db.execute("insert into items(item_name) values('soap')");
    await db.execute("insert into items(item_name) values('shampoo')");
  }

  Future<List<Item>> getItems() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("select item_name from items");
    List<Item> items = new List();
    for (int i = 0; i < list.length; i++) {
      items.add(new Item(list[i]["item_name"]));
    }
    return items;
  }
}