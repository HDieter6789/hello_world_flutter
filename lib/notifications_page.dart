import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'base_page.dart';
import 'notifications_provider.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  static const String _counterKey = 'notification_counter';
  int _localCounter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();

    // Reset Badge wenn geöffnet
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationsProvider>().resetBadge();
    });
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _localCounter = prefs.getInt(_counterKey) ?? 0;
    });
  }

  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _localCounter++;
    });
    await prefs.setInt(_counterKey, _localCounter);

    // Badge erhöhen
    await context.read<NotificationsProvider>().incrementBadge();
  }

  @override
  Widget build(BuildContext context) {
    final newCommits = context.watch<NotificationsProvider>().newCommitMessages;

    return BasePage(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (newCommits.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: newCommits.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text('$e - Eine neue Version ist verfügbar'),
                  );
                }).toList(),
              )
            else
              const Text('Keine neuen Mitteilungen.'),

            const SizedBox(height: 40),
            Text('Interner Zähler: $_localCounter'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text('Zähler erhöhen'),
            ),
          ],
        ),
      ),
    );
  }
}
