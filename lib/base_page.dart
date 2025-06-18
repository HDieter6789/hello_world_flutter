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
      backgroundColor: const Color(0xFFF7EDF8),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Suche...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                      ),
                      onSubmitted: (value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchResultPage(query: value),
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
                            color: Colors.blue, // Auffällige Farbe
                            size: 30,           // Größer
                          ),
                        ),
                        child: actions!.first,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}
