import 'package:flutter/material.dart';
import 'package:sushalika/model/list.dart';
import 'package:sushalika/database/dbhelper.dart';
import 'package:sushalika/list_items.dart';
import 'package:sushalika/items_list.dart';
import 'package:sushalika/item_list_all.dart';
import 'package:sushalika/about_page.dart';
import 'package:sushalika/help_page.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Lists', style: TextStyle(color: Colors.white, fontFamily: 'Oxygen'),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                  Row(),
//                  Padding(
//                    padding: const EdgeInsets.symmetric(vertical: 2.0),
//                    child: Icon(Icons.account_circle, size: 45.0, color: Colors.white,),
//                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 8.0),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text('Sushalika', style: TextStyle(fontSize: 48.0, fontFamily: 'Amperzand', color: Colors.white),),
                    ),
                  ),

                  Text('Shopping lists, made easy', style: TextStyle(fontSize: 14.0, color: Colors.white70, fontFamily: 'Oxygen'),),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.lightGreen,
                gradient: LinearGradient(colors: [
                  Colors.lightGreen[900],
                  Colors.lightGreen[700],
                  Colors.lightGreen[500],
                  Colors.lightGreen[400],
                ])
              ),
            ),
            ListTile(
              leading: Icon(Icons.list, color: Colors.lightGreen,),
              title: Text('All Items', style: Theme.of(context).textTheme.body1,),
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                  return new ItemListCompletePage();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.lightGreen,),
              title: Text('About', style: Theme.of(context).textTheme.body1,),
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                  return new AboutPage();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: Colors.lightGreen,),
              title: Text('Help', style: Theme.of(context).textTheme.body1,),
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                  return new HelpPage();
                }));
              },
            ),
          ],
        ),
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
                      String listName = snapshot.data[index].listName;
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                child: Text(listName==''?'u':listName[0]),
                                backgroundColor: Colors.lightGreen[100],
                                foregroundColor: Colors.lightGreen[900],
                              ),
                              title: Text(snapshot.data[index].listName, style: TextStyle(fontSize: 18.0, color: Colors.lightGreen[700]),),
                              subtitle: Text('Created at ${snapshot.data[index].createdAt}', style: TextStyle(color: Colors.grey, fontSize: 16.0),),
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
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemListPage(listName: 'Untitled',listItems: null,)));
            setState(() {
              getShoppingLists();
            });
          },
      child: Icon(Icons.add, color: Colors.white,),),
    );
  }
}
