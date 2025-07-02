import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  final Map<String, Widget> _favorites = {};

  Map<String, Widget> get favorites => _favorites;

  bool isFavorite(String pageKey) => _favorites.containsKey(pageKey);

  void toggleFavorite(String pageKey, Widget page) async {
    if (_favorites.containsKey(pageKey)) {
      _favorites.remove(pageKey);
      await _removeFromPrefs(pageKey);
    } else {
      _favorites[pageKey] = page;
      await _addToPrefs(pageKey);
    }
    notifyListeners();
  }

  // 👇 Neue Methoden zum Speichern und Laden
  Future<void> loadFavorites(Map<String, Widget> allPages) async {
    final prefs = await SharedPreferences.getInstance();
    final savedKeys = prefs.getStringList('favoritePageKeys') ?? [];
    _favorites.clear();
    for (var key in savedKeys) {
      if (allPages.containsKey(key)) {
        _favorites[key] = allPages[key]!;
      }
    }
    notifyListeners();
  }

  Future<void> _addToPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('favoritePageKeys') ?? [];
    if (!saved.contains(key)) {
      saved.add(key);
      await prefs.setStringList('favoritePageKeys', saved);
    }
  }

  Future<void> _removeFromPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('favoritePageKeys') ?? [];
    saved.remove(key);
    await prefs.setStringList('favoritePageKeys', saved);
  }
}
