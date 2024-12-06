// screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _isLoading = false;

  Future<void> _register() async {
    setState(() { _isLoading = true; });
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final success = await auth.register(_nameCtrl.text.trim(), _emailCtrl.text.trim(), _passCtrl.text.trim());
    setState(() { _isLoading = false; });
    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Inscription échouée')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("S'inscrire")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nameCtrl, decoration: InputDecoration(labelText: 'Nom')),
            TextField(controller: _emailCtrl, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _passCtrl, decoration: InputDecoration(labelText: 'Mot de passe'), obscureText: true),
            SizedBox(height: 20),
            _isLoading 
              ? CircularProgressIndicator()
              : ElevatedButton(onPressed: _register, child: Text("Valider l'inscription")),
          ],
        ),
      ),
    );
  }
}
