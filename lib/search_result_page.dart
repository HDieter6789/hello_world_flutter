import 'package:flutter/material.dart';
import 'base_page.dart';

class SearchResultPage extends StatefulWidget {
  final String query;

  const SearchResultPage({super.key, required this.query});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pop(context); // zurück zur Startseite
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasePage(
        child: Center(
          child: Text(
            'Suchergebnisse für: "${widget.query}"',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.blue.shade800,
            unselectedItemColor: Colors.blue.shade200,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Start',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favoriten',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.storage),
                label: 'Daten',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Mitteilungen',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Map',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
