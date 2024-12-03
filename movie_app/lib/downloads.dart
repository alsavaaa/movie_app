import 'package:flutter/material.dart';

class DownloadsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloads'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Text(
          'You have no downloads yet.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
