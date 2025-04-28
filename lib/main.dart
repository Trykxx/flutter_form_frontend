import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String nom = '';
  String prenom = '';
  String email = '';

  // Fonction pour envoyer les données
  void sendData() async {
    final url = Uri.parse('http://10.0.2.2:8000/user/store'); // Convertit l'URL du point d'API en objet Uri (10.0.2.2 correspond à localhost depuis l'émulateur)

    // Envoi des données
    try {
      final response = await http.post( // Exécute une requête HTTP POST et attend la réponse
        url, // URL du point de terminaison de l'API
        headers: {'Content-Type': 'application/json'}, // Définit le type de contenu comme JSON
        body: json.encode({ // Convertit les données en format JSON en ajoutant les champs dans la requete
          'nom': nom,
          'prenom': prenom,
          'email': email,
        }),
      );

      if (response.statusCode == 200) { // Vérifie si la requête a réussi (code HTTP 200)
        print('Succès! Réponse du serveur: ${response.body}'); // Affiche la réponse du serveur dans la console

      } else {
        print('Erreur: ${response.statusCode}');

      }
    } catch (e) {
      print('Exception: $e');

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Formulaire'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Input du nom
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  nom = newValue;
                },
              ),
              const SizedBox(height: 10),

              // Input du prénom
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  prenom = newValue;
                },
              ),
              const SizedBox(height: 10),

              // Input de l'email
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  email = newValue;
                },
              ),
              const SizedBox(height: 20),

              // Bouton de soumission
              ElevatedButton(
                onPressed: sendData,
                child: const Text('Envoyer'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
