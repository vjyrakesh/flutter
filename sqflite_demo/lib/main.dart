import 'package:flutter/material.dart';
import 'package:sqflite_demo/shopping_list.dart';
import 'package:sqflite_demo/list_items.dart';
import 'package:sqflite_demo/items_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Database Demo',
      home: ShoppingListsPage()
    );
  }
}

