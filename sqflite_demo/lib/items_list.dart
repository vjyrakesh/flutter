import 'package:flutter/material.dart';
import 'package:sqflite_demo/model/item.dart';
import 'package:sqflite_demo/database/dbhelper.dart';

Future<List<Item>> fetchItemsFromDatabase() async {
  var dbHelper = DBHelper();
  return dbHelper.getItems();
}

class ItemListPage extends StatefulWidget {
  @override
  ItemListState createState() => ItemListState();
}

class ItemListState extends State<ItemListPage> {
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
}