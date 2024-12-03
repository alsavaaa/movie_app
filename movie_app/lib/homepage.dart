import 'package:flutter/material.dart';
import 'api_services.dart';
import 'movie_card.dart';
import 'detailfilm.dart';
import 'profile.dart';
import 'file.dart';
import 'downloads.dart';

class MovieHomePage extends StatefulWidget {
  @override
  _MovieHomePageState createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  List movies = [];
  String searchQuery = '';
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MovieContent(),
    FilesPage(),
    DownloadsPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    try {
      final data = await ApiService.fetchMovies();
      setState(() {
        movies = data;
      });
    } catch (error) {
      print('Error fetching movies: $error');
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nonton Film Yuk'),
        backgroundColor: Colors.indigo,
        elevation: 2,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Files',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'Downloads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class MovieContent extends StatefulWidget {
  @override
  _MovieContentState createState() => _MovieContentState();
}

class _MovieContentState extends State<MovieContent> {
  List movies = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    try {
      final data = await ApiService.fetchMovies();
      setState(() {
        movies = data;
      });
    } catch (error) {
      print('Error fetching movies: $error');
    }
  }

  List filterMovies() {
    if (searchQuery.isEmpty) return movies;
    return movies
        .where((movie) =>
            movie['title'].toString().toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search movies, drama, etc...',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TabBar(
                  isScrollable: true,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey.shade400,
                  indicator: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  tabs: [
                    Tab(text: 'ALL'),
                    Tab(text: 'TV'),
                    Tab(text: 'MOVIES'),
                    Tab(text: 'DRAMAS'),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                buildMovieList(filterMovies()),
                buildMovieList(filterMovies()), // Adjust for TV API if needed
                buildMovieList(filterMovies()), // Adjust for MOVIES API if needed
                buildMovieList(filterMovies()), // Adjust for DRAMAS API if needed
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMovieList(List filteredMovies) {
    return filteredMovies.isEmpty
        ? Center(child: Text('No movies found'))
        : ListView.builder(
            itemCount: filteredMovies.length,
            itemBuilder: (context, index) {
              final movie = filteredMovies[index];
              return MovieCard(
                title: movie['title'],
                imagePath: movie['image'],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailPage(movie: movie),
                    ),
                  );
                },
              );
            },
          );
  }
}
