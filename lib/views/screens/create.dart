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
  List<String> recordsNames = [''];

  void _createRank() {
    final Function createRank = Injector.get<UserService>().createRank;

    var rank = Rank.fromMap({
      'name': name,
      'records': recordsNames.map((e) => {'name': e}),
    });

    createRank(rank);
  }

  void onReorder(oldIndex, newIndex) {
    print(oldIndex);
    print(newIndex);
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = recordsNames.removeAt(oldIndex);
      recordsNames.insert(newIndex, item);
    });
  }

  void addRecord() {
    setState(() {
      recordsNames.add('');
    });
  }

  void onRemoveRecord(i) {
    print(i);
    setState(() {
      recordsNames.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Create rank'),
          ),
          body: SafeArea(
            child: 
              Stack(
                children: <Widget>[
                  buildForm(),
                  // if (userService.isWaiting)
                  //   FittedBox(
                  //     child: CircularProgressIndicator(),
                  //   )
                ],
          )   
          )
    );
  }

  Widget buildForm() {
    return Container(
      padding: EdgeInsets.all(20),
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
                      name = value;
                    },
                  ),
                  Flexible(
                    child:
                  ReorderableListView(
                    children: buildRecordsInputs(),
                    onReorder: onReorder,
                  )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      RaisedButton(child: Icon(Icons.add), onPressed: addRecord),
                      RaisedButton(
                        color: Theme.of(context).accentColor,
                        textTheme: ButtonTextTheme.primary,
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
                    ]
                  )
                ],
              ),
            ),
    );
  }
  buildRecordsInputs() {
    var i = 0;
    List inputs = recordsNames.map((e) {
      var j = i++;
      return 
      Container(
        color: Color(e.hashCode),

        key: Key(e),
      child: Row(
        children: <Widget>[
          SizedBox(width: 20),
          Icon(Icons.drag_handle),
          SizedBox(width: 20),
          Flexible(
            child: 
            TextFormField(
              initialValue: e,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (value) {
                recordsNames[j] = value;
              },
              onEditingComplete: () {
                setState(() {
                });
              },
            )

          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => setState(() {
              print(j);
              recordsNames.removeAt(j);
            }),
          )
        ],

      )
      );
    }
    ).toList();
    return inputs;
  }
}
