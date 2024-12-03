import 'package:flutter/material.dart';
import 'downloads.dart';
import 'file.dart';
import 'homepage.dart';
import 'profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/',
      routes: {
        '/': (context) => MovieHomePage(),
        '/downloads': (context) => DownloadsPage(),
        '/files': (context) => FilesPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
