import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mitteilungen")),
      body: const Center(
        child: Text("Hello World – Mitteilungen", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
