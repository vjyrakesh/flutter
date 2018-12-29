import 'package:flutter/material.dart';
import 'package:sqflite_demo/model/list_item.dart';
import 'package:sqflite_demo/database/dbhelper.dart';

Future<List<ShoppingListItem>> fetchItemsInList() async {
  var dbHelper = DBHelper();
  return dbHelper.getShoppingListItems(1);
}

class ShoppingListItemsPage extends StatefulWidget {
  @override
  ShoppingListItemsState createState() => ShoppingListItemsState();
}

class ShoppingListItemsState extends State<ShoppingListItemsPage> {
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
        title: Text('list1'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: FutureBuilder<List<ShoppingListItem>>(
          future: fetchItemsInList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.arrow_right),
                          title: Text(snapshot.data[index].itemName, style: TextStyle(fontSize: 18.0),),
                          subtitle: Text('Quantity: ${snapshot.data[index].itemQuantity}', style: TextStyle(color: Colors.grey),),
                        ),
                        Divider(),
                      ],
                    );
                  }
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return Container(
              alignment: AlignmentDirectional.center,
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}