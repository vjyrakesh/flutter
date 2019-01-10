import 'package:flutter/material.dart';
import 'package:sushalika/database/dbhelper.dart';
import 'package:sushalika/model/item.dart';

Future<List<Item>> getItemList() async {
  var dbHelper = DBHelper();
  return dbHelper.getItems();
}

Future<int> addNewItem(String itemName) async {
  var dbHelper = DBHelper();
  return await dbHelper.addNewItem(itemName);
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
        _showItemNameDialog();
      },
      child: Icon(Icons.add),),
    );
  }

  _showItemNameDialog() async {
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
                      labelText: 'Item Name',
                      hintText: 'Cinthol soap'
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
                  int recId = await addNewItem(textController.text);
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