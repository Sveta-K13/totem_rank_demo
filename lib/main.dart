import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:totem_rank_demo/services/UserService.dart';

import './views/screens/home.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Injector(
      inject: [
        Inject(() => UserService()),
      ],
      builder: (_) => MaterialApp(
        title: 'Totem rank Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}