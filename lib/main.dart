import 'package:flutter/material.dart';

import 'AddDogScreen.dart';
import 'DogListScreen.dart';
import 'EditDogScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog CRUD App',
      initialRoute: '/',
      routes: {
        '/': (context) => DogListScreen(),
        '/add': (context) => AddDogScreen(),
        '/edit': (context) => EditDogScreen(
              dogId: 0,
            ),
      },
    );
  }
}
