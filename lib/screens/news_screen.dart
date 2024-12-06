// news_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/auth_provider.dart';
import '../services/api_service.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> _news = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    // Ici, pas besoin du token car on a dit que l'accès est public.
    final result = await ApiService.fetchNews();
    setState(() {
      _news = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualités'),
      ),
      body: _isLoading 
        ? Center(child: CircularProgressIndicator()) 
        : ListView.builder(
            itemCount: _news.length,
            itemBuilder: (ctx, i) {
              final article = _news[i];
              return ListTile(
                leading: article['imageUrl'] != null
                  ? CachedNetworkImage(
                      imageUrl: 'http://192.168.1.30:5000${article['imageUrl']}',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : Icon(Icons.article),
                title: Text(article['title'] ?? 'Sans titre'),
                subtitle: Text(article['summary'] ?? ''),
              );
            },
          ),
    );
  }
}
