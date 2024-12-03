import 'package:flutter/material.dart';

class FilesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My File'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Text(
          'This is the My File page.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
