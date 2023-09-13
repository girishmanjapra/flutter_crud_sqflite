import 'package:dog_app/database/database_helper.dart';
import 'package:flutter/material.dart';

class AddDogScreen extends StatefulWidget {
  @override
  _AddDogScreenState createState() => _AddDogScreenState();
}

class _AddDogScreenState extends State<AddDogScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  void _addDog() async {
    String name = _nameController.text.trim();
    int age = int.tryParse(_ageController.text.trim()) ?? 0;

    if (name.isNotEmpty && age > 0) {
      Map<String, dynamic> dog = {
        'name': name,
        'age': age,
      };
      await _dbHelper.insertDog(dog);
      // Navigator.pop(context); // Go back to the previous page
      Navigator.pushNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Dog'),
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
              onPressed: _addDog,
              child: Text('Add Dog'),
            ),
          ],
        ),
      ),
    );
  }
}
