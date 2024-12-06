// screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    // Supposons que l'API renvoie l'ID utilisateur dans le token ou que vous l'ayez stocké
    // Ici, on utilise juste un placeholder, tu devras adapter cette partie
    final userId = '1'; 
    final result = await ApiService.fetchProfile(auth.token!, userId);
    setState(() {
      _user = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Profil')),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : _user == null ?
        Center(child: Text('Utilisateur introuvable')) :
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _user!['imageUrl'] != null
              ? CachedNetworkImage(imageUrl: 'http://192.168.1.30:5000${_user!['imageUrl']}', width: 100, height: 100, fit: BoxFit.cover)
              : Icon(Icons.person, size: 100),
              SizedBox(height: 16),
              Text(_user!['name'] ?? '', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text(_user!['email'] ?? '', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  auth.logout();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Se déconnecter')
              )
            ],
          ),
        ),
    );
  }
}
