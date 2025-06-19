import 'package:flutter/material.dart';
import 'search_result_page.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final List<Widget>? actions;

  const BasePage({
    super.key,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Hintergrund mit Verlauf
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.blueAccent],
                ),
              ),
            ),
          ),

          // Inhalt
          Column(
            children: [
              const SizedBox(height: 40), // Platz für Statusleiste
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Suche...',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        onSubmitted: (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SearchResultPage(query: value),
                            ),
                          );
                        },
                      ),
                    ),
                    if (actions != null && actions!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            iconTheme: const IconThemeData(
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                          child: actions!.first,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(child: child),
            ],
          ),
        ],
      ),
    );
  }
}