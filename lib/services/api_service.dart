// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'http://192.168.1.30:5000/api';

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}));
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'email': email, 'password': password}));
    return json.decode(response.body);
  }

  static Future<List<dynamic>> fetchPlaces(String token) async {
    final url = Uri.parse('$baseUrl/tourism');
    final response = await http.get(url, headers: _authHeaders(token));
    return json.decode(response.body);
  }

  static Future<List<dynamic>> fetchEvents(String token) async {
    final url = Uri.parse('$baseUrl/events');
    final response = await http.get(url, headers: _authHeaders(token));
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> fetchProfile(String token, String userId) async {
    final url = Uri.parse('$baseUrl/users/$userId');
    final response = await http.get(url, headers: _authHeaders(token));
    return json.decode(response.body);
  }

  static Map<String, String> _authHeaders(String token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }
  static Future<List<dynamic>> fetchNews() async {
    final url = Uri.parse('$baseUrl/news');
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});
    return json.decode(response.body);
  }
}
