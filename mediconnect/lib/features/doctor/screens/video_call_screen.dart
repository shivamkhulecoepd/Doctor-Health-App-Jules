import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediconnect/core/widgets/glass_card.dart';
import 'package:animate_do/animate_do.dart';

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
              'https://images.unsplash.com/photo-1559839734-2b71f1536783?q=80&w=2070',
              fit: BoxFit.cover,
            ),
          ),
          // User Video (PIP)
          Positioned(
            top: 60.h,
            right: 24.w,
            child: FadeInRight(
              child: Container(
                width: 120.w,
                height: 180.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20)],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.r),
                  child: Container(
                    color: Colors.grey[900],
                    child: _isVideoOff
                      ? Center(child: Icon(Icons.videocam_off_rounded, color: Colors.white.withOpacity(0.5), size: 32.sp))
                      : Image.network('https://i.pravatar.cc/150?u=sarah', fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          // Call Info
          Positioned(
            top: 64.h,
            left: 24.w,
            child: FadeInLeft(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. Marcus Horizon',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22.sp, letterSpacing: 0.5),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      ),
                      SizedBox(width: 8.w),
                      Text('10:24 Live', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14.sp)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Controls
          Positioned(
            bottom: 60.h,
            left: 24.w,
            right: 24.w,
            child: FadeInUp(
              child: GlassCard(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                blur: 20,
                opacity: 0.15,
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(32.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlButton(
                      icon: _isMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
                      color: _isMuted ? Colors.redAccent.withOpacity(0.8) : Colors.white.withOpacity(0.2),
                      onTap: () => setState(() => _isMuted = !_isMuted),
                    ),
                    _buildControlButton(
                      icon: _isVideoOff ? Icons.videocam_off_rounded : Icons.videocam_rounded,
                      color: _isVideoOff ? Colors.redAccent.withOpacity(0.8) : Colors.white.withOpacity(0.2),
                      onTap: () => setState(() => _isVideoOff = !_isVideoOff),
                    ),
                    _buildControlButton(
                      icon: Icons.call_end_rounded,
                      color: Colors.redAccent,
                      onTap: () => context.pop(),
                      isLarge: true,
                    ),
                    _buildControlButton(
                      icon: Icons.flip_camera_ios_rounded,
                      color: Colors.white.withOpacity(0.2),
                      onTap: () {},
                    ),
                    _buildControlButton(
                      icon: Icons.chat_bubble_rounded,
                      color: Colors.white.withOpacity(0.2),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({required IconData icon, required Color color, required VoidCallback onTap, bool isLarge = false}) {
    final size = isLarge ? 64.r : 52.r;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: isLarge ? 32.sp : 24.sp),
      ),
    );
  }
}
