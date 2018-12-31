import 'package:flutter/material.dart';
import 'package:sushalika/model/list.dart';
import 'package:sushalika/database/dbhelper.dart';
import 'package:sushalika/list_items.dart';

Future<List<ShoppingList>> getShoppingLists() async {
  DBHelper dbClient = DBHelper();
  return dbClient.getShoppingLists();
}

class ShoppingListsPage extends StatefulWidget {
  @override
  ShoppingListsState createState() => ShoppingListsState();
}

class ShoppingListsState extends State<ShoppingListsPage> {
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
        title: Text('Shopping Lists'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: FutureBuilder<List<ShoppingList>>(
            future: getShoppingLists(),
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
                                child: Text(snapshot.data[index].listName[0]),
                              ),
                              title: Text(snapshot.data[index].listName, style: TextStyle(fontSize: 18.0),),
                              subtitle: Text('Created at ${snapshot.data[index].createdAt}', style: TextStyle(color: Colors.grey),),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ShoppingListItemsPage(list_name: snapshot.data[index].listName,))
                                );
                              },
                            ),
                            Divider()
                          ]
                      );
                    }
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return Container(alignment: AlignmentDirectional.center, child: CircularProgressIndicator(),);
            }
        ),
      ),
    );
  }
}
