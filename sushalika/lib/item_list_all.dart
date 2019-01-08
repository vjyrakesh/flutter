import 'package:flutter/material.dart';
import 'package:sushalika/database/dbhelper.dart';
import 'package:sushalika/model/item.dart';

Future<List<Item>> getItemList() async {
  var dbHelper = DBHelper();
  return dbHelper.getItems();
}


class ItemListCompletePage extends StatefulWidget {
  @override
  ItemListCompleteState createState() => ItemListCompleteState();
}

class ItemListCompleteState extends State<ItemListCompletePage> {

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
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.done, color: Colors.white,), onPressed: (){

          })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: FutureBuilder<List<Item>> (
          future: getItemList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  String itemName = snapshot.data[index].name;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Text(itemName[0]),
                        ),
                        title: Text(itemName, style: TextStyle(fontSize: 16.0),),
                      ),
                      Divider()
                    ],
                  );
                });
            } else if (snapshot.hasError) {
              return Text(snapshot.error);
            }
            return Container(alignment: AlignmentDirectional.center, child: CircularProgressIndicator(),);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

      },
      child: Icon(Icons.add),),
    );
  }
}