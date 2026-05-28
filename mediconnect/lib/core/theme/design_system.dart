import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesignSystem {
  // Spacing
  static double get spaceXS => 4.w;
  static double get spaceS => 8.w;
  static double get spaceM => 16.w;
  static double get spaceL => 24.w;
  static double get spaceXL => 32.w;
  static double get spaceXXL => 48.w;

  // Radius
  static double get radiusS => 8.r;
  static double get radiusM => 16.r;
  static double get radiusL => 24.r;
  static double get radiusXL => 32.r;
  static BorderRadius get borderM => BorderRadius.circular(radiusM);
  static BorderRadius get borderL => BorderRadius.circular(radiusL);

  // Shadows
  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ];

  static List<BoxShadow> get premiumShadow => [
        BoxShadow(
          color: const Color(0xFF1F2687).withOpacity(0.08),
          blurRadius: 30,
          offset: const Offset(0, 10),
        ),
      ];
}
