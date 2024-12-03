import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  final Map movie;

  MovieDetailPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie['title'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(movie['image']),
            SizedBox(height: 16),
            Text('Rating: ${movie['rank']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text(movie['description'] ?? 'No description available'),
          ],
        ),
      ),
    );
  }
}
