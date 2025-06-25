import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Karte")),
      body: const Center(
        child: Text("Hello World – Karte", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
