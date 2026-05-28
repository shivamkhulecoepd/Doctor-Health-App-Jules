import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _isMuted = false;
  bool _isVideoOff = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main Doctor Video (Placeholder)
          Positioned.fill(
            child: Image.network(
              'https://i.pravatar.cc/600?u=doc1',
              fit: BoxFit.cover,
            ),
          ),
          // User Video (PIP)
          Positioned(
            top: 60,
            right: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 120,
                height: 180,
                color: Colors.grey[800],
                child: _isVideoOff
                  ? const Center(child: Icon(Icons.videocam_off, color: Colors.white))
                  : Image.network('https://i.pravatar.cc/150?u=user', fit: BoxFit.cover),
              ),
            ),
          ),
          // Call Info
          Positioned(
            top: 60,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Dr. Marcus Horizon', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
                  child: const Row(
                    children: [
                      Icon(Icons.fiber_manual_record, color: Colors.red, size: 12),
                      SizedBox(width: 5),
                      Text('10:24', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildControlButton(
                  icon: _isMuted ? Icons.mic_off : Icons.mic,
                  color: _isMuted ? Colors.red : Colors.white24,
                  onTap: () => setState(() => _isMuted = !_isMuted),
                ),
                const SizedBox(width: 20),
                _buildControlButton(
                  icon: Icons.call_end,
                  color: Colors.red,
                  onTap: () => Navigator.pop(context),
                  size: 70,
                ),
                const SizedBox(width: 20),
                _buildControlButton(
                  icon: _isVideoOff ? Icons.videocam_off : Icons.videocam,
                  color: _isVideoOff ? Colors.red : Colors.white24,
                  onTap: () => setState(() => _isVideoOff = !_isVideoOff),
                ),
                const SizedBox(width: 20),
                _buildControlButton(
                  icon: Icons.flip_camera_ios,
                  color: Colors.white24,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({required IconData icon, required Color color, required VoidCallback onTap, double size = 56}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: size * 0.5),
      ),
    );
  }
}
