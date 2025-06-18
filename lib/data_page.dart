import 'package:flutter/material.dart';
import 'base_page.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: const Center(
        child: Text(
          'Hier könnten Ihre Daten stehen.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
