// screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() { _isLoading = true; });
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final success = await auth.login(_emailCtrl.text.trim(), _passCtrl.text.trim());
    setState(() { _isLoading = false; });
    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Identifiants invalides')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connexion')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _emailCtrl, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _passCtrl, decoration: InputDecoration(labelText: 'Mot de passe'), obscureText: true),
            SizedBox(height: 20),
            _isLoading 
              ? CircularProgressIndicator()
              : ElevatedButton(onPressed: _login, child: Text('Se connecter')),
            TextButton(onPressed: () => Navigator.pushNamed(context, '/register'), child: Text("S'inscrire"))
          ],
        ),
      ),
    );
  }
}
