// home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'screens/places_screen.dart';
import 'screens/events_screen.dart';
import 'screens/news_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      PlacesScreen(),
      EventsScreen(),
      NewsScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Daralabé Explorer'),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.person),
            onSelected: (value) {
              final auth = Provider.of<AuthProvider>(context, listen: false);
              if (value == 'connexion') {
                Navigator.pushNamed(context, '/login');
              } else if (value == 'inscrire') {
                Navigator.pushNamed(context, '/register');
              } else if (value == 'profil') {
                Navigator.pushNamed(context, '/profile');
              } else if (value == 'admin') {
                Navigator.pushNamed(context, '/admin');
              } else if (value == 'deconnexion') {
                auth.logout();
              }
            },
            itemBuilder: (ctx) {
              final auth = Provider.of<AuthProvider>(ctx, listen: false);
              if (!auth.isAuth) {
                // Non authentifié : options Connexion et S'inscrire
                return [
                  PopupMenuItem(value: 'connexion', child: Text('Connexion')),
                  PopupMenuItem(value: 'inscrire', child: Text("S'inscrire")),
                ];
              } else {
                // Authentifié : options Admin, Profil, Déconnexion
                return [
                  PopupMenuItem(value: 'admin', child: Text("Panneau (d'administration)")),
                  PopupMenuItem(value: 'profil', child: Text("Profil")),
                  PopupMenuItem(value: 'deconnexion', child: Text("Déconnexion")),
                ];
              }
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Lieux'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Événements'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Actualités'),
        ],
      ),
    );
  }
}
