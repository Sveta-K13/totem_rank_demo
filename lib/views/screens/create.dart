import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:totem_rank_demo/models/entities/Rank.dart';
import 'package:totem_rank_demo/services/UserService.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = '';
  List<Map> records = [];

  void _createRank() {
    final Function createRank = Injector.get<UserService>().createRank;

    var rank = Rank.fromMap({
      'name': name,
      'records': records,
    });

    createRank(rank);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Create rank'),
          ),
          body:    
              Stack(
                children: <Widget>[
                  buildForm(),
                  // if (userService.isWaiting)
                  //   FittedBox(
                  //     child: CircularProgressIndicator(),
                  //   )
                ],
          )
    );
  }

  Center buildForm() {
    return Center(
          child: 
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 300),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'name',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      print(value);
                      name = value;
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        _createRank();
                        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Rank created')));
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
