import 'package:flutter/material.dart';
import 'package:sushalika/shopping_list.dart';
import 'package:sushalika/list_items.dart';
import 'package:sushalika/items_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'Database Demo',
        home: ItemListPage()
    );
  }
}

