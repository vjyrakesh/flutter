import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: null)
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Text('Sample settings page'),
      ),
    );
  }
}