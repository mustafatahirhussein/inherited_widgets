import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inheritedwidgets/stateContainer.dart';
import 'user.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: myForm(),
    );
  }
}

class myForm extends StatefulWidget {
  @override
  myFormState createState() => myFormState();
}

class myFormState extends State<myForm> {
  String name;
  final _formKey = GlobalKey<FormState>();

  validateAndSave() {
    final container = StateContainer.of(context);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      container.updateUser(name: name);
      Navigator.pop(context);
    } else {
      print('Validation error.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Validation'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (val) => val.length == 0 ? 'Enter Name' : null,
                    onSaved: (val) => name = val,
                    decoration: InputDecoration(labelText: 'Enter Name'),
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  RaisedButton(child: Text('Save'), onPressed: validateAndSave),
                ]),
          ),
        ),
      ),
    );
  }
}
