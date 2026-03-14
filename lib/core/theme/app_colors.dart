import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary brand — indigo-violet
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primarySurface = Color(0xFFEEF2FF);

  // Accent
  static const Color accent = Color(0xFF8B5CF6);

  // Semantic
  static const Color success = Color(0xFF10B981);
  static const Color successSurface = Color(0xFFD1FAE5);
  static const Color error = Color(0xFFEF4444);
  static const Color errorSurface = Color(0xFFFEE2E2);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningSurface = Color(0xFFFEF3C7);

  // Backgrounds
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  // Text
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textHint = Color(0xFF94A3B8);

  // Border / Divider
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFF1F5F9);

  // Task states
  static const Color taskCompleted = Color(0xFF94A3B8);

  // Gradient stops
  static const List<Color> primaryGradient = [
    Color(0xFF6366F1),
    Color(0xFF8B5CF6),
  ];

  static const List<Color> heroGradient = [
    Color(0xFF4F46E5),
    Color(0xFF7C3AED),
  ];

  // Legacy aliases (keep backward compatibility)
  static const Color primaryColor = primary;
  static const Color accentColor = accent;
  static const Color backgroundColor = background;
  static const Color surfaceColor = surface;
  static const Color errorColor = error;
  static const Color successColor = success;
  static const Color textHintColor = textHint;
  static const Color dividerColor = border;
  static const Color completedTaskColor = taskCompleted;
}
