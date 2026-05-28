import 'package:flutter/material.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});

  @override
  State<SOSScreen> createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  int _countdown = 3;
  bool _isCounting = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _startCountdown() async {
    setState(() => _isCounting = true);
    for (int i = 3; i > 0; i--) {
      if (!mounted) return;
      setState(() => _countdown = i);
      await Future.delayed(const Duration(seconds: 1));
    }
    // After countdown, trigger emergency action
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF3B30), Color(0xFF8B0000)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                ),
              ),
              const Spacer(),
              Text(
                'EMERGENCY SOS',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                'Help is coming soon. Press and hold the button.',
                style: TextStyle(color: Colors.white70),
              ),
              const Spacer(),
              GestureDetector(
                onLongPressStart: (_) => _startCountdown(),
                onLongPressEnd: (_) => setState(() {
                  _isCounting = false;
                  _countdown = 3;
                }),
                child: Center(
                  child: AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                            width: 2 + (10 * _pulseController.value),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: _isCounting
                                  ? Text(
                                      '$_countdown',
                                      style: const TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFF3B30),
                                      ),
                                    )
                                  : const Icon(
                                      Icons.power_settings_new,
                                      size: 60,
                                      color: Color(0xFFFF3B30),
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Spacer(),
              _buildEmergencyContacts(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyContacts() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildContactAvatar('Wife'),
          _buildContactAvatar('Dad'),
          _buildContactAvatar('911'),
          _buildContactAvatar('Hospital'),
        ],
      ),
    );
  }

  Widget _buildContactAvatar(String name) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(name, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
