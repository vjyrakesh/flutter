import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'dart:async';
import 'package:my_device_info/about_page.dart';
import 'package:my_device_info/settings_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My device information',
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('My Device Info'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.info, color: Colors.grey,),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (context){ return new AboutPage(); }));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.grey,),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (context){ return new SettingsPage(); }));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Device Info', style: TextStyle(fontSize: 32.0, color: Colors.grey),),
      ),
    );
  }
}


