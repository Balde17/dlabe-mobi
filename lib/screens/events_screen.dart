// screens/events_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<dynamic> _events = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final result = await ApiService.fetchEvents(auth.token!);
    setState(() {
      _events = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Événements')),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount: _events.length,
        itemBuilder: (ctx, i) {
          final event = _events[i];
          return ListTile(
            leading: event['imageUrl'] != null
              ? CachedNetworkImage(imageUrl: 'http://192.168.1.30:5000${event['imageUrl']}', width: 50, height: 50, fit: BoxFit.cover)
              : Icon(Icons.event),
            title: Text(event['title']),
            subtitle: Text(event['description'] ?? ''),
          );
        },
      ),
    );
  }
}
