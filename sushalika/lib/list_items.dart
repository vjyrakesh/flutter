import 'package:flutter/material.dart';
import 'package:sushalika/model/list_item.dart';
import 'package:sushalika/database/dbhelper.dart';
import 'package:sushalika/items_list.dart';
import 'package:uuid/uuid.dart';

Future<List<ShoppingListItem>> fetchItemsInList(String list_name) async {
  var dbHelper = DBHelper();
  return dbHelper.getShoppingListItems(list_name);
}

Future<int> removeOneItem(String listName, String itemName) async {
  var dbHelper = DBHelper();
  return await dbHelper.removeOneItemFromList(listName, itemName);
}

class ShoppingListItemsPage extends StatefulWidget {
  final String list_name;

  ShoppingListItemsPage({Key key, @required this.list_name}): super(key:key);

  @override
  ShoppingListItemsState createState() => ShoppingListItemsState();
}

class ShoppingListItemsState extends State<ShoppingListItemsPage> {
  String removedItem = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String list_name = widget.list_name;
    return Scaffold(
      appBar: AppBar(
        title: Text(list_name),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: FutureBuilder<List<ShoppingListItem>>(
          future: fetchItemsInList(list_name),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(Uuid().v4().toString()),
                      background: Container(color: Colors.red,),
                      onDismissed: (direction) async {

                        removedItem = snapshot.data[index].itemName;
                        await removeOneItem(list_name, removedItem);
                      },
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              child: Text(snapshot.data[index].itemName[0]),
                            ),
                            title: Text(snapshot.data[index].itemName, style: TextStyle(fontSize: 18.0),),
                            subtitle: Text('Quantity: ${snapshot.data[index].itemQuantity}', style: TextStyle(color: Colors.grey),),
                          ),
                          Divider(),
                        ],
                      ),
                    );
                  }
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Center(
                  child: Container(
                    alignment: Alignment(0.0, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.error, size: 60.0, color: Colors.grey,),
                        Text('No items in this list', style: TextStyle(fontSize: 28.0, color: Colors.grey),)
                      ],
                    ),
                  )
              );
            }
            return Container(
              alignment: AlignmentDirectional.center,
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        List<ShoppingListItem> listItems = await fetchItemsInList(list_name);
        Map<String,String> listItemsMap = new Map();
        if (listItems != null) {
          for (ShoppingListItem oneItem in listItems) {
            listItemsMap[oneItem.itemName] = oneItem.itemQuantity;
          }
        }
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return ItemListPage(listName: list_name, listItems: listItemsMap);
        }));
      },
      child: Icon(Icons.add),)
    );
  }
}