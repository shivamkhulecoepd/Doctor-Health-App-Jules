import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorSearchScreen extends StatefulWidget {
  const DoctorSearchScreen({super.key});

  @override
  State<DoctorSearchScreen> createState() => _DoctorSearchScreenState();
}

class _DoctorSearchScreenState extends State<DoctorSearchScreen> {
  final List<String> _filters = ['All', 'Cardiology', 'Dermatology', 'Neurology', 'Pediatrics'];
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Find Doctors', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: const MediTextField(
              hintText: 'Search doctors, clinic...',
              prefixIcon: Icons.search_rounded,
            ),
          ),
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedFilter == index;
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: FilterChip(
                    label: Text(_filters[index]),
                    selected: isSelected,
                    onSelected: (selected) => setState(() => _selectedFilter = index),
                    selectedColor: colorScheme.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                      fontSize: 13.sp,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    backgroundColor: colorScheme.surface,
                    side: BorderSide(color: isSelected ? colorScheme.primary : colorScheme.outlineVariant),
                    showCheckmark: false,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: 5,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInUp(
                  delay: Duration(milliseconds: index * 100),
                  child: _buildDoctorCard(context, index),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Map View', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: colorScheme.onInverseSurface)),
        icon: Icon(Icons.map_rounded, color: colorScheme.onInverseSurface, size: 20.sp),
        backgroundColor: colorScheme.inverseSurface,
        elevation: 4,
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context, int index) {
    final colorScheme = Theme.of(context).colorScheme;
    return MediCard(
      padding: EdgeInsets.all(12.r),
      onTap: () => context.push('/doctor/doc_$index'),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: DesignSystem.borderM,
                child: Image.network('https://i.pravatar.cc/150?u=doc$index', width: 90.w, height: 90.w, fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 5.r,
                right: 5.r,
                child: Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: colorScheme.secondary,
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.surface, width: 2),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dr. Maria Elena', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp, color: colorScheme.onSurface)),
                Text('Psychologist • San Jose Hospital', style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12.sp)),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: colorScheme.tertiary, size: 18.sp),
                    SizedBox(width: 4.w),
                    Text('4.9', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp, color: colorScheme.onSurface)),
                    Text(' (120 reviews)', style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12.sp)),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Next: Tomorrow, 09:00 AM',
                  style: TextStyle(color: colorScheme.primary, fontSize: 11.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
