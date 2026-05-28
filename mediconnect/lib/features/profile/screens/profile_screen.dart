import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _isCardFlipped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=user')),
            const SizedBox(height: 15),
            const Text('Sarah Adams', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const Text('ID: MC-2023-8942', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 30),
            _buildHealthIDCard(),
            const SizedBox(height: 30),
            _buildProfileSection('General', [
              _buildProfileItem(Icons.person_outline, 'Personal Info', () {}),
              _buildProfileItem(Icons.family_restroom, 'Family Members', () {}),
              _buildProfileItem(Icons.history, 'Medical History', () {}),
            ]),
            const SizedBox(height: 20),
            _buildProfileSection('Preferences', [
              _buildProfileItem(Icons.settings_outlined, 'Settings', () => context.push('/settings')),
              _buildProfileItem(Icons.lock_outline, 'Privacy & Security', () => context.push('/privacy')),
              _buildProfileItem(Icons.help_outline, 'Help & Support', () => context.push('/support')),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthIDCard() {
    return GestureDetector(
      onTap: () => setState(() => _isCardFlipped = !_isCardFlipped),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          final rotate = Tween(begin: 3.14, end: 0.0).animate(animation);
          return AnimatedBuilder(
            animation: rotate,
            builder: (context, widget) {
              final isUnder = (ValueKey(_isCardFlipped) != child.key);
              var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
              tilt *= isUnder ? -1.0 : 1.0;
              final value = isUnder ? (rotate.value - 3.14) : rotate.value;
              return Transform(
                transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
                alignment: Alignment.center,
                child: widget,
              );
            },
            child: child,
          );
        },
        child: _isCardFlipped ? _buildCardBack() : _buildCardFront(),
      ),
    );
  }

  Widget _buildCardFront() {
    return Container(
      key: const ValueKey(false),
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primary, Color(0xFF0055FF)]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('HEALTH ID CARD', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
              const Icon(Icons.medical_services, color: Colors.white70),
            ],
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SARAH ADAMS', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              Text('DOB: 12/05/1995', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('BLOOD TYPE: A+', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
              Container(padding: const EdgeInsets.all(5), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)), child: const Icon(Icons.qr_code, size: 30)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      key: const ValueKey(true),
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('EMERGENCY CONTACT', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
          SizedBox(height: 10),
          Text('Name: John Adams', style: TextStyle(fontWeight: FontWeight.w500)),
          Text('Relationship: Spouse', style: TextStyle(color: AppColors.textSecondary)),
          Text('Phone: +1 234 567 890', style: TextStyle(color: AppColors.textSecondary)),
          SizedBox(height: 20),
          Text('ALLERGIES: Peanuts, Penicillin', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildProfileSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildProfileItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}
