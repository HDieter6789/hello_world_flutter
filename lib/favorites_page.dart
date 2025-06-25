import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favoriten")),
      body: const Center(
        child: Text("Hello World – Favoriten", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
