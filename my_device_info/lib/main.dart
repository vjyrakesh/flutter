import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My device information',
      home: MyDeviceInfo(),
    );
  }
}

class MyDeviceInfo extends StatefulWidget {
  @override
  MyDeviceInfoState createState() => MyDeviceInfoState();
}

class MyDeviceInfoState extends State<MyDeviceInfo> {
  DeviceInfoPlugin _deviceInfoPlugin;
  @override
  void initState() {
    super.initState();
    _deviceInfoPlugin = DeviceInfoPlugin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Device Info'),
        ),
        body: FutureBuilder<AndroidDeviceInfo>(
          future: _deviceInfoPlugin.androidInfo,
          builder: (BuildContext context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final androidDeviceInfo = snapshot.data;

              return ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                    leading: Icon(Icons.info),
                    title: Text('Android build version: ${androidDeviceInfo.version.release}',
                    style: TextStyle(fontSize: 18.0),),
                    )
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.info),
                      title: Text('Android device: ${androidDeviceInfo.device}', style: TextStyle(fontSize: 18.0),),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.info),
                      title: Text('Android device hardware: ${androidDeviceInfo.hardware}', style: TextStyle(fontSize: 18.0),),
                    )
                  )
                ],
              );
            }
          },
        ),
    );
  }
}
