import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius? borderRadius;
  final Border? border;
  final EdgeInsetsGeometry? padding;
  final GestureTapCallback? onTap;
  final Color? color;

  const GlassCard({
    super.key,
    required this.child,
    this.blur = 20.0,
    this.opacity = 0.72,
    this.borderRadius,
    this.border,
    this.padding,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cardBorderRadius = borderRadius ?? BorderRadius.circular(24);
    final cardDecoration = BoxDecoration(
      color: color ?? Colors.white.withOpacity(opacity),
      borderRadius: cardBorderRadius,
      border: border ?? Border.all(color: Colors.white.withOpacity(0.3), width: 1),
    );

    final content = ClipRRect(
      borderRadius: cardBorderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: cardDecoration,
          child: child,
        ),
      ),
    );

    if (onTap == null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: cardBorderRadius,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1F2687).withOpacity(0.07),
              blurRadius: 32,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: content,
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: cardBorderRadius,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2687).withOpacity(0.07),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: cardBorderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: cardBorderRadius,
          child: content,
        ),
      ),
    );
  }
}
