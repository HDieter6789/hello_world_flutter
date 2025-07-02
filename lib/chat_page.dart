import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  final types.User _user = const types.User(id: 'user');

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    final welcome = types.TextMessage(
      author: const types.User(id: 'bot', firstName: 'HOT Bot'),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: 'Hallo! Ich bin der HOT Bot 🤖\nWie kann ich dir helfen?\nHier sind ein paar Fragen, die du mir stellen kannst:',
    );

    setState(() {
      _messages.insert(0, welcome);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });

    final botReply = types.TextMessage(
      author: const types.User(id: 'bot', firstName: 'HOT Bot'),
      createdAt: DateTime.now().millisecondsSinceEpoch + 500,
      id: const Uuid().v4(),
      text: _generateBotReply(message.text),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.insert(0, botReply);
      });
    });
  }

  String _generateBotReply(String question) {
    final lower = question.toLowerCase();
    if (lower.contains('daten')) {
      return 'Die Seite „Daten“ zeigt dir wichtige Feiertage und deren Werte.';
    } else if (lower.contains('karte') || lower.contains('map')) {
      return 'Die Karte zeigt dir Köln und du kannst Orte suchen.';
    } else if (lower.contains('sprache')) {
      return 'Ich verstehe Deutsch und Englisch.';
    } else {
      return 'Gute Frage! Ich lerne noch – bitte stelle eine andere zur App.';
    }
  }

  void _handleQuickQuestion(String question) {
    _handleSendPressed(types.PartialText(text: question));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // keine AppBar – wir bauen alles direkt ins Layout ein
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  // Hauptinhalt links (kann leer bleiben)
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.transparent,
                      child: const Center(
                        child: Text(
                          'Willkommen im Support-Bereich der App!',
                          style: TextStyle(fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  // Chatbereich rechts (1/4 Breite)
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(-2, 0),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              '💬 HOT Bot',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                ElevatedButton(
                                  onPressed: () => _handleQuickQuestion('Was sehe ich auf der Datenseite?'),
                                  child: const Text('Was sehe ich auf der Datenseite?'),
                                ),
                                ElevatedButton(
                                  onPressed: () => _handleQuickQuestion('Wie benutze ich die Karte?'),
                                  child: const Text('Wie benutze ich die Karte?'),
                                ),
                                ElevatedButton(
                                  onPressed: () => _handleQuickQuestion('Welche Sprache spricht der Bot?'),
                                  child: const Text('Welche Sprache spricht der Bot?'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(height: 1),
                          // Chat selbst
                          Expanded(
                            child: Chat(
                              messages: _messages,
                              onSendPressed: _handleSendPressed,
                              user: _user,
                              showUserAvatars: true,
                              showUserNames: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
