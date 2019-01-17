import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text('Sushalika', style: TextStyle(fontSize: 36.0, fontFamily: 'Amperzand'),),
              ),
              Text('Version: 0.1.0', style: TextStyle(fontSize: 18.0, color: Colors.grey),),
              Text('Copyrights Rakesh Kasibhatla, 2019', style: TextStyle(fontSize: 16.0, color: Colors.grey),),
              Text('Made with Flutter 1.0', style: TextStyle(fontSize: 16.0, color: Colors.grey),),
            ],
          )
      ),
    );
  }
}