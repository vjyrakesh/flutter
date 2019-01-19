/// Helper class to interact with SQLite database.

import 'dart:async';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sushalika/model/item.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sushalika/model/list.dart';

class DBItemsUpdater {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  /// Initialise the database.
  /// Makes a working copy of the database from the bundle to get the items.
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "working_items_copy.db");
    io.FileSystemEntity fileObj = new io.File(path);
    if (fileObj.existsSync()) {
      fileObj.deleteSync();
    }
    ByteData data = await rootBundle.load(join("assets", "shopping.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new io.File(path).writeAsBytes(bytes);

    var theDb = await openDatabase(path);
    return theDb;
  }

  /// Get the complete list of items from the database.
  Future<List<Item>> getItems() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("select item_name from items order by item_name");
    List<Item> items = new List();
    for (int i = 0; i < list.length; i++) {
      items.add(new Item(list[i]["item_name"]));
    }
    return items;
  }

  Future<List<ShoppingList>> getShoppingLists() async {
    print('in dbupdater getshoppinglists');
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("select list_name,list_created_at from lists order by list_created_at desc");
    List<ShoppingList> shoppingLists = new List();
    for (int i = 0; i < list.length; i++) {
      shoppingLists.add(new ShoppingList(list[i]['list_name'], list[i]['list_created_at']));
    }
    return shoppingLists;
  }
}