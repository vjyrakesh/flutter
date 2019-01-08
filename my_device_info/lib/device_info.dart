import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:uuid/uuid.dart';

class MyDeviceInfo extends StatefulWidget {
  final String testStr='';
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
    final String testVal = widget.testStr;
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
                Dismissible(
                  key: Key(Uuid().v4().toString()),
                  background: Container(color: Colors.red,),
                  onDismissed: (direction){

                  },
                  child: ListTile(
                    leading: Icon(Icons.info),
                    title: Text('Android build version: ${androidDeviceInfo.version.release}',
                      style: TextStyle(fontSize: 18.0),),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Android device: ${androidDeviceInfo.device}',
                    style: TextStyle(fontSize: 18.0),),
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Android device hardware: ${androidDeviceInfo.hardware}', style: TextStyle(fontSize: 18.0),),
                )
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
        child: Icon(Icons.add),
      ),
    );
  }
}