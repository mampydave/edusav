import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Color(
    0xFF1565C0,
  ); // Bleu header (comme ton écran Welcome)
  static const primaryDark = Color(0xFF0D47A1);
  static const accent = Color(
    0xFF4CAF50,
  ); // Vert pour exemples / bonnes réponses
  static const important = Color(0xFFF44336); // Rouge pour essentiel / erreurs
  static const background = Color(0xFFF5F5F5);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);

  // Dark mode
  static const darkBackground = Color(0xFF121212);
  static const darkSurface = Color(0xFF1E1E1E);
  static const darkTextPrimary = Color(0xFFE0E0E0);
  static const darkTextSecondary = Color(0xFFB0B0B0);
}
