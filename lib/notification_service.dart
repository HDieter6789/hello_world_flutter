import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static const String _lastSeenKey = 'last_seen_commit_date';

  static final List<String> _commitDates = [
    '30.06.2025',
    '28.06.2025',
    '25.06.2025',
  ];

  static Future<List<String>> getNewCommitMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSeen = prefs.getString(_lastSeenKey);

    final newCommits = lastSeen == null
        ? _commitDates
        : _commitDates.where((date) => _isNewer(date, lastSeen)).toList();

    return newCommits;
  }

  static Future<void> markAllAsSeen() async {
    final prefs = await SharedPreferences.getInstance();
    if (_commitDates.isNotEmpty) {
      await prefs.setString(_lastSeenKey, _commitDates.first);
    }
  }

  static Future<int> getNewCommitCount() async {
    final commits = await getNewCommitMessages();
    return commits.length;
  }

  static bool _isNewer(String current, String lastSeen) {
    final curParts = current.split('.').map(int.parse).toList();
    final lastParts = lastSeen.split('.').map(int.parse).toList();

    final curDate = DateTime(curParts[2], curParts[1], curParts[0]);
    final lastDate = DateTime(lastParts[2], lastParts[1], lastParts[0]);

    return curDate.isAfter(lastDate);
  }
}
