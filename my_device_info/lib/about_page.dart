import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _aboutScaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _aboutScaffoldKey,
      appBar: AppBar(
        title: Text('About'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.done, color: Colors.white,), onPressed: (){
            _aboutScaffoldKey.currentState.showSnackBar(SnackBar(content: Text('About done clicked')));
//            Scaffold.of(context).showSnackBar(SnackBar(content: Text('About clicked')));
          })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Text('Sample demo app'),
      ),
    );
  }
}