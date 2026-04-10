import 'package:flutter/material.dart';

class AppColors {

  static const text = Colors.black87;
  // Primary brand (soft blue)
  static const primary = Color(0xFF5B8DEF);       
  static const primaryLight = Color(0xFF8FB3FF);
  static const primaryDark = Color(0xFF3A6EDC);

  // Backgrounds (very soft)
  static const background = Color(0xFFF7F9FC);    
  static const surface = Color(0xFFFFFFFF);
  static const cardBg = Color(0xFFFFFFFF);
  static const cardBorder = Color(0xFFE3EAF5);

  // State colors (soft, not harsh)
  static const success = Color(0xFF6FBF73);       
  static const successLight = Color(0xFFEAF7ED);

  static const error = Color(0xFFE57373);         
  static const errorLight = Color(0xFFFFEBEE);

  static const warning = Color(0xFFFFB74D);       
  static const warningLight = Color(0xFFFFF3E0);

  static const locked = Color(0xFFB0BEC5);
  static const lockedLight = Color(0xFFF1F3F4);

  // Text (softer contrast)
  static const textPrimary = Color(0xFF2C3E50);
  static const textSecondary = Color(0xFF546E7A);
  static const textMuted = Color(0xFF90A4AE);
  static const textOnPrimary = Color(0xFFFFFFFF);

  // Level colors (pastel, friendly)
  static const level1 = Color(0xFF64B5F6); // Soft Blue
  static const level2 = Color(0xFF81C784); // Soft Green
  static const level3 = Color(0xFFFFB74D); // Soft Orange
  static const level4 = Color(0xFFBA68C8); // Soft Purple
  static const level5 = Color(0xFFE57373); // Soft Red

  static Color levelColor(int level) {
    switch (level) {
      case 1: return level1;
      case 2: return level2;
      case 3: return level3;
      case 4: return level4;
      case 5: return level5;
      default: return primary;
    }
  }

  static Color levelLight(int level) {
    switch (level) {
      case 1: return Color(0xFFE3F2FD);
      case 2: return Color(0xFFE8F5E9);
      case 3: return Color(0xFFFFF3E0);
      case 4: return Color(0xFFF3E5F5);
      case 5: return Color(0xFFFFEBEE);
      default: return Color(0xFFE3F2FD);
    }
  }

  // XP bar
  static const xpBar = Color(0xFF5B8DEF);
  static const xpBarBg = Color(0xFFD6E4FF);
}