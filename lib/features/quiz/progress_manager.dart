import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProgressManager {
  static const _scoresKey = 'level_scores';

  // Save score of a level
  static Future<void> saveScore(int level, int score) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_scoresKey);

    Map<String, dynamic> scores = {};

    if (data != null) {
      scores = jsonDecode(data);
    }

    scores[level.toString()] = score;

    await prefs.setString(_scoresKey, jsonEncode(scores));
  }

  // Get score of one level
  static Future<int?> getScore(int level) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_scoresKey);

    if (data == null) return null;

    final scores = jsonDecode(data) as Map<String, dynamic>;
return scores[level.toString()] as int?;
  }

  // Get all scores
  static Future<Map<int, int>> getAllScores() async {
  final prefs = await SharedPreferences.getInstance();
  final data = prefs.getString(_scoresKey);

  if (data == null) return {};

  final decoded = jsonDecode(data) as Map<String, dynamic>;

  return decoded.map(
    (key, value) => MapEntry(
      int.parse(key),
      value is int ? value : int.parse(value.toString()),
    ),
  );
}

  // Reset
  static Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_scoresKey);
  }
}