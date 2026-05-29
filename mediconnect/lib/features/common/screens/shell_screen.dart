import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/widgets/bottom_nav_bar.dart';
import 'package:animate_do/animate_do.dart';

class ShellScreen extends StatelessWidget {
  final Widget child;
  const ShellScreen({super.key, required this.child});

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/messages')) return 1;
    if (location.startsWith('/health')) return 2; // Using health for the wallet/card icon placeholder
    if (location.startsWith('/appointments')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0: context.go('/home'); break;
      case 1: context.go('/messages'); break;
      case 2: context.go('/health'); break;
      case 3: context.go('/appointments'); break;
      case 4: context.go('/profile'); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: CustomBottomNavBar(
                currentIndex: _getSelectedIndex(context),
                onTap: (index) => _onItemTapped(index, context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
