import 'package:dog_app/database/database_helper.dart';
import 'package:flutter/material.dart';

import '../models/class_dog.dart';

class DogListScreen extends StatefulWidget {
  @override
  _DogListScreenState createState() => _DogListScreenState();
}

class _DogListScreenState extends State<DogListScreen> {
  List<Dog> _dogs = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadDogs();
  }

  _loadDogs() async {
    List<Map<String, dynamic>> dogs = await _dbHelper.getDogs();
    setState(() {
      _dogs = dogs
          .map((data) => Dog(
                id: data['id'],
                name: data['name'],
                age: data['age'],
              ))
          .toList();
    });
  }

  _deleteDog(int dogId) async {
    await _dbHelper.deleteDog(dogId);
    _loadDogs();
  }

  _navigateToEditDog(int dogId) {
    Navigator.pushNamed(context, '/edit', arguments: dogId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dog List'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(
                    context, '/add'); // Navigate to the Add Dog page
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: _dogs.length,
          itemBuilder: (context, index) {
            final dog = _dogs[index];
            return Dismissible(
              key: Key(dog.id.toString()), // Provide a unique key for each item
              background: Container(
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 30,
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20.0),
              ),
              onDismissed: (direction) {
                _deleteDog(dog.id); // Call the delete function when dismissed
              },
              child: ListTile(
                title: Text(dog.name),
                subtitle: Text('Age: ${dog.age} years'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteDog(dog
                        .id); // Call the delete function when the delete icon is tapped
                  },
                ),
                onTap: () {
                  _navigateToEditDog(
                      dog.id); // Navigate to the edit page when tapped
                },
              ),
            );
          },
        ));
  }
}
