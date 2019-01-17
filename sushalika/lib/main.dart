import 'package:flutter/material.dart';
import 'package:sushalika/shopping_list.dart';
import 'package:sushalika/list_items.dart';
import 'package:sushalika/items_list.dart';
import 'package:sushalika/item_list_all.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'Sushalika',
        home: ShoppingListsPage(),
        routes: <String, WidgetBuilder> {
          '/itemsListPage': (BuildContext context) => new ItemListPage(listName: '', listItems: null,),
          '/shoppingListsPage': (BuildContext context) => new ShoppingListsPage(),
          '/shoppingListItemsPage': (BuildContext context) => new ShoppingListItemsPage(list_name: '')
        },
        theme: ThemeData(
          primaryColor: Colors.lightGreen[500],
          accentColor: Colors.lightGreen[500],
          textTheme: TextTheme(
            title: TextStyle(fontSize: 22.0, fontFamily: 'Oxygen', fontWeight: FontWeight.bold, color: Colors.lightGreen[900]),
            body1: TextStyle(fontSize: 18.0, fontFamily: 'Oxygen', color: Colors.lightGreen[700])
          )
        ),
    );
  }
}

class SushalikaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Sushalika'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Sushalika', style: TextStyle(fontSize: 32.0, color: Colors.white),),
                    Text('Shopping lists, made easy', style: TextStyle(fontSize: 14.0, color: Colors.white70),)
                  ],
                ),
              decoration: BoxDecoration(
                color: Colors.lightBlue
              ),
            ),
            ListTile(
              leading: Icon(Icons.list, color: Colors.grey,),
              title: Text('All Items'),
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                  return new ItemListCompletePage();
                }));
              },
            ),

          ],
        ),
      ),
    );
  }
}

