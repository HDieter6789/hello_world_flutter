import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsProvider with ChangeNotifier {
  static const String _lastSeenKey = 'last_seen_commit_date';
  static const String _badgeCounterKey = 'badge_counter';

  List<String> _newCommitMessages = [];
  int _badgeCount = 0;

  List<String> get newCommitMessages => _newCommitMessages;
  int get badgeCount => _badgeCount;

  Future<void> loadCommitCount() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSeen = prefs.getString(_lastSeenKey);

    final commitDates = [
      '30.06.2025',
      '28.06.2025',
      '25.06.2025',
    ];

    _newCommitMessages = lastSeen == null
        ? commitDates
        : commitDates.where((date) => _isNewer(date, lastSeen)).toList();

    notifyListeners();
  }

  Future<void> markAllAsRead() async {
    final prefs = await SharedPreferences.getInstance();
    final commitDates = [
      '30.06.2025',
      '28.06.2025',
      '25.06.2025',
    ];

    if (commitDates.isNotEmpty) {
      await prefs.setString(_lastSeenKey, commitDates.first);
      _newCommitMessages.clear();
      notifyListeners();
    }
  }

  Future<void> incrementBadge() async {
    final prefs = await SharedPreferences.getInstance();
    _badgeCount = (prefs.getInt(_badgeCounterKey) ?? 0) + 1;
    await prefs.setInt(_badgeCounterKey, _badgeCount);
    notifyListeners();
  }

  Future<void> resetBadge() async {
    final prefs = await SharedPreferences.getInstance();
    _badgeCount = 0;
    await prefs.setInt(_badgeCounterKey, 0);
    notifyListeners();
  }

  Future<void> loadBadge() async {
    final prefs = await SharedPreferences.getInstance();
    _badgeCount = prefs.getInt(_badgeCounterKey) ?? 0;
    notifyListeners();
  }

  bool _isNewer(String current, String lastSeen) {
    final curParts = current.split('.').map(int.parse).toList();
    final lastParts = lastSeen.split('.').map(int.parse).toList();

    final curDate = DateTime(curParts[2], curParts[1], curParts[0]);
    final lastDate = DateTime(lastParts[2], lastParts[1], lastParts[0]);

    return curDate.isAfter(lastDate);
  }
}
