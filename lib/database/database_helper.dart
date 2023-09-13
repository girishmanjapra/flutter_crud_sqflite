import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DogListScreen(),
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'dogs.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        );
      },
    );
  }

  Future<int> insertDog(Map<String, dynamic> dog) async {
    Database? dbClient = await db;
    return await dbClient!.insert('dogs', dog);
  }

  Future<List<Map<String, dynamic>>> getDogs() async {
    Database? dbClient = await db;
    return await dbClient!.query('dogs');
  }

  Future<int> updateDog(Map<String, dynamic> dog) async {
    Database? dbClient = await db;
    return await dbClient!.update(
      'dogs',
      dog,
      where: 'id = ?',
      whereArgs: [dog['id']],
    );
  }

  Future<int> deleteDog(int dogId) async {
    Database? dbClient = await db;
    return await dbClient!.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [dogId],
    );
  }

  getDog(int dogId) {}
}

class DogListScreen extends StatefulWidget {
  @override
  _DogListScreenState createState() => _DogListScreenState();
}

class _DogListScreenState extends State<DogListScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDogs();
  }

  _loadDogs() async {
    setState(() {});
  }

  _clearTextFields() {
    _nameController.text = '';
    _ageController.text = '';
  }

  _addDog() async {
    String name = _nameController.text.trim();
    int age = int.tryParse(_ageController.text.trim()) ?? 0;

    if (name.isNotEmpty && age > 0) {
      _clearTextFields();
      _loadDogs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog CRUD App'),
      ),
    );
  }
}
