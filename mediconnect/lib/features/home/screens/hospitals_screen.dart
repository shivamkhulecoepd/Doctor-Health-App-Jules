import "package:mediconnect/shared/widgets/reusable_widgets.dart";
import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class NearbyHospitalsScreen extends StatelessWidget {
  const NearbyHospitalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Hospitals')),
      body: Stack(
        children: [
          // Mock Map Background
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?q=80&w=2066',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 20.h,
            left: 24.w,
            right: 24.w,
            child: const AppSearchBar(hintText: 'Search hospital or clinic...'),
          ),
          Positioned(
            bottom: 40.h,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 180.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildHospitalCard(context, index, isDark);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHospitalCard(BuildContext context, int index, bool isDark) {
    final names = ['San Jose Hospital', 'Grace Clinic', 'Central Medical'];
    return Container(
      width: 300.w,
      margin: EdgeInsets.only(right: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network('https://images.unsplash.com/photo-1587350859728-117622bc75fb?q=80&w=2070', width: 60.w, height: 60.w, fit: BoxFit.cover),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(names[index], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('General Hospital • 1.2 km', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 12.sp)),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.orange, size: 16),
                      SizedBox(width: 4.w),
                      const Text('4.8', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Text('Open 24/7', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 11)),
                ],
              ),
              PrimaryButton(text: 'Directions', onPressed: () {}, fullWidth: false),
            ],
          ),
        ],
      ),
    );
  }
}
