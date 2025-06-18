import 'package:flutter/material.dart';
import 'data_page.dart';
import 'search_result_page.dart';
import 'base_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _showMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Hello World – $text')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.blue),
          onSelected: (value) => _showMessage(context, value),
          itemBuilder: (BuildContext context) {
            return ['Service', 'Einstellungen', 'Version', 'Profil']
                .map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/Logo HOT GMBH.png',
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: const Text('Hallo Welt!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Klick mich!'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DataPage(),
                    ),
                  );
                },
                child: const Text('Daten anzeigen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
