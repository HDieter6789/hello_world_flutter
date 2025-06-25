import 'package:flutter/material.dart';
import 'base_page.dart';

class SearchResultPage extends StatelessWidget {
  final String query;

  const SearchResultPage({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Center(
        child: Text(
          'Suchergebnisse für: "$query"',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
