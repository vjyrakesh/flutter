import 'package:flutter/material.dart';
import 'package:sushalika/model/item.dart';
import 'package:sushalika/database/dbhelper.dart';
import 'package:sushalika/model/list_item.dart';

Future<List<Item>> fetchItemsFromDatabase() async {
  var dbHelper = DBHelper();
  return dbHelper.getItems();
}

class ItemListPage extends StatefulWidget {
  @override
  ItemListState createState() => ItemListState();
}

class ItemListState extends State<ItemListPage> {
  Map<String, String> shoppingListItemMap = new Map();
  String currSel = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
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
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                child: Text(snapshot.data[index].name[0]),
                              ),
                              title: Text(snapshot.data[index].name, style: TextStyle(fontSize: 16.0),),
                              subtitle: Text('Quantity: ${shoppingListItemMap.containsKey(snapshot.data[index].name)?shoppingListItemMap[snapshot.data[index].name]:''}'),
                              trailing: Icon(Icons.add_shopping_cart, color: Colors.green,),
                              onTap: (){
                                shoppingListItemMap[snapshot.data[index].name] = '';
                                currSel = snapshot.data[index].name;
                                _showDialog();
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

  _showDialog() async {
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
}