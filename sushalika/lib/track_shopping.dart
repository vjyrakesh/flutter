import 'package:flutter/material.dart';
import 'package:sushalika/database/dbhelper.dart';
import 'package:sushalika/model/list_item.dart';
import 'package:uuid/uuid.dart';

Future<List<ShoppingListItem>> fetchItemsInList(String list_name) async {
  var dbHelper = DBHelper();
  return dbHelper.getShoppingListItems(list_name);
}

class TrackShoppingPage extends StatefulWidget {
  final String listName;

  TrackShoppingPage({Key key, @required this.listName}): super(key:key);

  @override
  TrackShoppingPageState createState() => new TrackShoppingPageState();
}

class TrackShoppingPageState extends State<TrackShoppingPage> {
  List<String> completedListItems = new List<String>();
  List<ShoppingListItem> listItemsFromDb;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchItemsInList(widget.listName).then((listItems){
      listItemsFromDb = new List<ShoppingListItem>();
      setState(() {
        for(var oneItem in listItems) {
          listItemsFromDb.add(oneItem);
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.listName, style: TextStyle(color: Colors.white, fontFamily: 'Oxygen'),),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check, color: Colors.white,),
            onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: ListView(
          children: getShoppingListWidgets(listItemsFromDb)
        ),
      ),
    );
  }

  List<Widget> getShoppingListWidgets(List<ShoppingListItem> listItems) {
    List<Widget> widgets = new List<Widget>();
    if (listItems != null) {
      for (var oneItem in listItems) {
        widgets.add(
          Dismissible(
            key: Key(Uuid().v4().toString()),
            background: Container(color: Colors.green,),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    child: Text(oneItem.itemName[0]),
                    backgroundColor: Colors.lightGreen[100],
                    foregroundColor: Colors.lightGreen[900],
                  ),
                  title: Text(oneItem.itemName,
                    style: TextStyle(fontSize: 18.0, color: Colors.lightGreen[700]),),
                  subtitle: Text('Quantity: ${oneItem.itemQuantity}',
                    style: TextStyle(color: Colors.grey),),
                  trailing: completedListItems.contains(oneItem.itemName)?Icon(Icons.done, color: Colors.green,):null,
                ),
                Divider(),
              ],
            ),
            onDismissed: (direction){
              
              setState(() {
                completedListItems.add(oneItem.itemName);
                listItemsFromDb.remove(oneItem);
                listItemsFromDb.add(oneItem);
              });

            })
        );

      }
    }
    return widgets;
  }
}