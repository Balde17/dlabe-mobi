// screens/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final _pages = [
    HomeContent(), // Un widget d'accueil qui pourrait mettre en avant des lieux en vedette
    Placeholder(), // plus tard remplacer par EventsScreen()
    Placeholder(), // plus tard remplacer par ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daralabé Explorer')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() { _selectedIndex = i; }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorer'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Événements'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Menu'), decoration: BoxDecoration(color: Colors.blue)),
            ListTile(
              leading: Icon(Icons.place),
              title: Text('Lieux'),
              onTap: () => Navigator.pushNamed(context, '/places'),
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Événements'),
              onTap: () => Navigator.pushNamed(context, '/events'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Bienvenue sur Daralabé Explorer'));
  }
}
