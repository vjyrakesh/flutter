import 'package:flutter/material.dart';
import 'package:sushalika/model/item.dart';
import 'package:sushalika/database/dbhelper.dart';
import 'package:sushalika/model/list_item.dart';
import 'package:sushalika/shopping_list.dart';

Future<List<Item>> fetchItemsFromDatabase() async {
  var dbHelper = DBHelper();
  return dbHelper.getItems();
}

Future<int> addShoppingListItemsToDB(String listName, Map<String,String> listItems) async {
  var dbHelper = DBHelper();
  return await dbHelper.addItemsToShoppingList(listName, listItems);
}

Future<int> removeItemsFromShoppingList(String listName) async {
  var dbHelper = DBHelper();
  return await dbHelper.removeItemsFromShoppingList(listName);
}

void removeShoppingList(String listName) async {
  var dbHelper = DBHelper();
  dbHelper.removeShoppingList(listName);
}

Future<int> getListId(String listName) async {
  var dbHelper = DBHelper();
  return dbHelper.getListId(listName);
}


class ItemListPage extends StatefulWidget {
  final String listName;
  final Map<String,String> listItems;

  ItemListPage({ Key key, @required this.listName, @required this.listItems}): super(key:key);

  @override
  ItemListState createState() => ItemListState();
}

class ItemListState extends State<ItemListPage> {
  Map<String, String> shoppingListItemMap = new Map();
  String currSel = '';
  String listName = 'Untitled';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.listItems != null)
      this.shoppingListItemMap = widget.listItems;
    if (widget.listName != null)
      this.listName = widget.listName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.done, color: Colors.white,), onPressed: () async {
            if (this.listName == 'Untitled') {
              _showListNameDialog();
            } else {
              await removeItemsFromShoppingList(this.listName);
              await addShoppingListItemsToDB(this.listName, shoppingListItemMap);
              Navigator.pop(context);
            }
          })
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(12.0),
          child: FutureBuilder<List<Item>> (
              future: fetchItemsFromDatabase(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final String itemName = snapshot.data[index].name;
                        final bool itemSaved = shoppingListItemMap.containsKey(itemName);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                child: Text(itemName[0]),
                              ),
                              title: Text(itemName, style: TextStyle(fontSize: 16.0),),
                              subtitle: Text('Quantity: ${shoppingListItemMap.containsKey(itemName)?shoppingListItemMap[itemName]:''}'),
                              trailing: Icon(Icons.add_shopping_cart, color: itemSaved?Colors.green:Colors.grey,),
                              onTap: (){
                                shoppingListItemMap[itemName] = '';
                                currSel = itemName;
                                _showQtyDialog();
                              },
                            ),
                            Divider()
                          ],
                        );
                      }
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Container(alignment: AlignmentDirectional.center,child: CircularProgressIndicator());
              }
          )
      ),
    );
  }

  _showQtyDialog() async {
    final textController = new TextEditingController();
    String retVal = await showDialog<String>(
        context: context,
        child: AlertDialog(
          contentPadding: EdgeInsets.all(12.0),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Quantity',
                      hintText: 'E.g. 100gm'
                  ),
                  controller: textController,
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('Cancel')
            ),
            FlatButton(
                onPressed: (){
                  Navigator.pop(context, textController.text);
//                textController.dispose();
                },
                child: Text('Save')
            )
          ],
        )
    );
    setState(() {
      shoppingListItemMap[currSel] = retVal;
    });
  }

  _showListNameDialog() async {
    final textController = new TextEditingController();
    String retVal = await showDialog<String>(
        context: context,
        child: AlertDialog(
          contentPadding: EdgeInsets.all(12.0),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'List Name',
                      hintText: 'Monthly groceries'
                  ),
                  controller: textController,
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('Cancel')
            ),
            FlatButton(
                onPressed: () async {
                  print('onPressed called');
                  int recId = await addShoppingListItemsToDB(textController.text, shoppingListItemMap);
                  if (recId > 0)
                    Navigator.pop(context, textController.text);
                  else {
//                    return Scaffold.of(context).showSnackBar(SnackBar(content: Text('Error in adding data')));
                  print('error occurred while addind data $recId');
                  }
                },
                child: Text('Save')
            )
          ],
        )
    );

    Navigator.pop(context);
  }
}