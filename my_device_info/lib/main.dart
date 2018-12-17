import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  DeviceInfoPlugin _deviceInfoPlugin;
  @override
  void initState() {
    super.initState();
    _deviceInfoPlugin = DeviceInfoPlugin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Device Info',
      home: Scaffold(
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
              return Center(
                child: Text('Android build version: ${androidDeviceInfo.version.release}'),
              );
            }
          },
        ),
      ),
    );
  }
}
