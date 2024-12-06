// admin_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    if (!auth.isAuth) {
      // Utilisateur non authentifié, on pourrait afficher un message ou le rediriger
      return Scaffold(
        appBar: AppBar(title: Text('Panneau d\'administration')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Vous devez être connecté pour accéder au panneau d'administration."),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Se connecter'),
              ),
            ],
          ),
        ),
      );
    }

    // Utilisateur authentifié
    return Scaffold(
      appBar: AppBar(title: Text('Panneau d\'administration')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Bienvenue sur le panneau d'administration", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ajouter un lieu - rediriger vers un écran de création de lieu
                // ou afficher un formulaire d'ajout
                Navigator.pushNamed(context, '/addPlace'); 
              },
              child: Text('Ajouter un lieu'),
            ),
            ElevatedButton(
              onPressed: () {
                // Ajouter un événement - rediriger vers un écran de création d'événement
                Navigator.pushNamed(context, '/addEvent'); 
              },
              child: Text('Ajouter un événement'),
            ),
            // On peut rajouter d'autres actions d'administration ici (modifier un lieu, un évènement, etc.)
          ],
        ),
      ),
    );
  }
}
