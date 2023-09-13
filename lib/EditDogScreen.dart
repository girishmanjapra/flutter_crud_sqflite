import 'package:dog_app/database_helper.dart';
import 'package:flutter/material.dart';

import 'class_dog.dart';

class EditDogScreen extends StatefulWidget {
  final int dogId;

  EditDogScreen({required this.dogId});

  @override
  _EditDogScreenState createState() => _EditDogScreenState();
}

class _EditDogScreenState extends State<EditDogScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late Dog _dog;

  @override
  void initState() {
    super.initState();
    _loadDogDetails();
  }

  _loadDogDetails() async {
    Dog dog = await _dbHelper.getDog(widget.dogId);
    setState(() {
      _dog = dog;
      _nameController.text = dog.name;
      _ageController.text = dog.age.toString();
    });
  }

  _updateDog() async {
    String name = _nameController.text.trim();
    int age = int.tryParse(_ageController.text.trim()) ?? 0;

    if (name.isNotEmpty && age > 0) {
      _dog.name = name;
      _dog.age = age;
      await _dbHelper.updateDog(_dog as Map<String, dynamic>);
      Navigator.pop(context); // Go back to the previous page (DogListScreen)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Dog'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateDog,
              child: Text('Update Dog'),
            ),
          ],
        ),
      ),
    );
  }
}
