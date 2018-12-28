import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cards demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cards demo'),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                child: Card(
                  elevation: 5.0,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0, color: Colors.blue),
                              borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                            ),
                            child: Image.asset(
                              'images/ProfilePic.jpg',
                              height: 80.0,
                              fit: BoxFit.contain,
                            ),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    'Rakesh\'s Birthday',
                                    style: TextStyle(
                                        fontSize: 32.0
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Icon(Icons.call, color: Theme.of(context).primaryColor,),
                              Container(
                                margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: Text(
                                  'Call',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Theme.of(context).primaryColor
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Icon(Icons.message, color: Theme.of(context).primaryColor,),
                              Container(
                                margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: Text(
                                  'SMS',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Theme.of(context).primaryColor
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Icon(Icons.chat, color: Theme.of(context).primaryColor,),
                              Container(
                                margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: Text(
                                  'Chat',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Theme.of(context).primaryColor
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Text('First item'),
              Text('Second item')
            ],
          ),
        ),
      ),
    );
  }
}