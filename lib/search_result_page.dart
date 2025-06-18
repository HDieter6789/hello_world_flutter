import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  final String? query;

  const SearchResultPage({super.key, this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suchergebnis'),
      ),
      body: Center(
        child: Text(
          query != null && query!.isNotEmpty
              ? 'Ergebnisse für: "$query"'
              : 'Hallo Welt',
          style: const TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
