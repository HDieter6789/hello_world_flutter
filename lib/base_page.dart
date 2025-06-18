import 'package:flutter/material.dart';
import 'search_result_page.dart';

class BasePage extends StatelessWidget {
  final Widget child;

  const BasePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    void _startSearch() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SearchResultPage(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextField(
                controller: _searchController,
                onSubmitted: (_) => _startSearch(),
                decoration: InputDecoration(
                  hintText: 'Suche...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _startSearch,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
