import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Forms Demo',
      home: FormDemoPage(),
    );
  }
}

class FormDemoPage extends StatefulWidget {
  @override
  _FormDemoState createState() => new _FormDemoState();
}

class _FormDemoState extends State<FormDemoPage> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _name = '';
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
        title: Text('Form Demo'),
      ),
      body:
        Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: ListView(
                children: getFormWidgets(),
              ),
            ),
        ),
    );
  }

  List<Widget> getFormWidgets() {
    List<Widget> widgetsList = List<Widget>();
    widgetsList.add(new Text('$_name'));
    widgetsList.add(new TextFormField(
      decoration: InputDecoration(
        labelText: 'Name',
        hintText: 'John Doe'
      ),
      validator: (value) {
        if(value.isEmpty) {
          return 'Please enter a name';
        }
      },
      onSaved: (value){
        setState(() {
          _name = value;
        });
      },
      controller: _textController,
    ));
    widgetsList.add(
      new RaisedButton(
          onPressed: (){
            if (_formKey.currentState.validate()) {
              setState(() {
                _name = _textController.text;
              });
            }
          },
      child: Text('Submit'),
      )
    );
    return widgetsList;
  }
}