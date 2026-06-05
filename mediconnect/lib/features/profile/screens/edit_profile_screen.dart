import "package:mediconnect/shared/widgets/reusable_widgets.dart";
import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.s24),
        child: Column(
          children: [
            _buildAvatarPicker(),
            SizedBox(height: 32.h),
            const AppSearchBar(hintText: 'Full Name'),
            SizedBox(height: 16.h),
            const AppSearchBar(hintText: 'Email Address'),
            SizedBox(height: 16.h),
            const AppSearchBar(hintText: 'Phone Number'),
            SizedBox(height: 16.h),
            const AppSearchBar(hintText: 'Home Address'),
            SizedBox(height: 48.h),
            PrimaryButton(text: 'Save Changes', onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarPicker() {
    return Stack(
      children: [
        CircleAvatar(radius: 50.r, backgroundImage: const NetworkImage('https://i.pravatar.cc/150?u=sarah')),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(8.r),
            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }
}
