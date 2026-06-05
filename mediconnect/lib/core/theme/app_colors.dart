import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFF7B61FF);
  static const Color primaryDark = Color(0xFF5A3FD4);
  static const Color primaryLight = Color(0xFFA78BFF);
  static const Color accent = Color(0xFFFF4081); // Hot Pink

  // Light Theme
  static const Color backgroundLight = Color(0xFFF4F6FF);
  static const Color surfaceLight = Colors.white;
  static const Color cardLight = Colors.white;
  static const Color textPrimaryLight = Color(0xFF1A1A2E);
  static const Color textSecondaryLight = Color(0xFF6B7280);

  // Dark Theme
  static const Color backgroundDark = Color(0xFF0F0F1A);
  static const Color surfaceDark = Color(0xFF1A1A2E);
  static const Color cardDark = Color(0xFF22223A);
  static const Color textPrimaryDark = Color(0xFFF0F0FF);
  static const Color textSecondaryDark = Color(0xFF9090B0);

  // Functional Colors
  static const Color error = Color(0xFFFF3B30);
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9500);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7B61FF), Color(0xFF9D4EDD)],
  );

  static LinearGradient headerGradient(bool isDark) {
    if (isDark) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF7B61FF).withOpacity(0.8),
          const Color(0xFF9D4EDD).withOpacity(0.8),
        ],
      );
    }
    return primaryGradient;
  }
}
