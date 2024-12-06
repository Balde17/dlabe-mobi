// screens/places_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlacesScreen extends StatefulWidget {
  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  List<dynamic> _places = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPlaces();
  }

  Future<void> _fetchPlaces() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final result = await ApiService.fetchPlaces(auth.token!);
    setState(() {
      _places = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lieux touristiques')),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount: _places.length,
        itemBuilder: (ctx, i) {
          final place = _places[i];
          return ListTile(
            leading: place['imageUrl'] != null
              ? CachedNetworkImage(imageUrl: 'http://192.168.1.30:5000${place['imageUrl']}', width: 50, height: 50, fit: BoxFit.cover)
              : Icon(Icons.image),
            title: Text(place['name']),
            subtitle: Text(place['description'] ?? ''),
          );
        },
      ),
    );
  }
}
