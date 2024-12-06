// providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  final storage = FlutterSecureStorage();

  bool get isAuth {
    return _token != null;
  }

  String? get token {
    return _token;
  }

  Future<void> tryAutoLogin() async {
    final savedToken = await storage.read(key: 'jwt');
    if (savedToken == null) {
      return;
    }
    _token = savedToken;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    final result = await ApiService.login(email, password);
    if (result['token'] != null) {
      _token = result['token'];
      await storage.write(key: 'jwt', value: _token);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    final result = await ApiService.register(name, email, password);
    if (result['token'] != null) {
      _token = result['token'];
      await storage.write(key: 'jwt', value: _token);
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() async {
    _token = null;
    await storage.delete(key: 'jwt');
    notifyListeners();
  }
}
