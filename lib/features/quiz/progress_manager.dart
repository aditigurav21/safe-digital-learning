import 'package:shared_preferences/shared_preferences.dart';

class ProgressManager {
  static const _unlockedKey = 'unlocked_level';
  static const _currentKey = 'current_level';

  static Future<int> getUnlockedLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_unlockedKey) ?? 1;
  }

  static Future<int> getCurrentLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_currentKey) ?? 1;
  }

  static Future<void> saveProgress(int unlockedLevel, int currentLevel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_unlockedKey, unlockedLevel);
    await prefs.setInt(_currentKey, currentLevel);
  }

  static Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_unlockedKey);
    await prefs.remove(_currentKey);
  }
}