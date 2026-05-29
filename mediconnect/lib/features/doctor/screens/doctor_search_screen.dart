import 'package:flutter/material.dart';
import 'package:mediconnect/core/services/mock_data_service.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:mediconnect/shared/widgets/doctor_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
    final doctors = MockDataService.doctors;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Doctors'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(AppSpacing.s24),
            child: const AppSearchBar(hintText: 'Search doctor or clinic...'),
          ),
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s24),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedFilter == index;
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedFilter = index),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: isSelected ? AppColors.primary : AppColors.textSecondaryLight.withOpacity(0.3)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _filters[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.textSecondaryLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: AppSpacing.s24),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s24),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
                childAspectRatio: 0.75,
              ),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                return DoctorCard(
                  doctor: doctors[index],
                  onTap: () => context.push('/doctor/${doctors[index].id}'),
                  onBookTap: () => context.push('/booking/${doctors[index].id}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
