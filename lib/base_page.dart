import 'package:flutter/material.dart';
import 'search_result_page.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final List<Widget>? actions;
  final String? title;

  const BasePage({
    Key? key,
    required this.child,
    this.actions,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: title != null
          ? AppBar(
        title: Text(title!),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: actions,
      )
          : null,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              if (title == null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            hintText: 'Suche...',
                            prefixIcon: const Icon(Icons.search, color: Colors.black54),
                            hintStyle: const TextStyle(color: Colors.black54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
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
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
