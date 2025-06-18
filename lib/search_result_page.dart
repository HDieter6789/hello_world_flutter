import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suchergebnis'),
      ),
      body: const Center(
        child: Text(
          'Hallo Welt',
          style: TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
