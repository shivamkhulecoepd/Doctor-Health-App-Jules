import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/appointment_card.dart';
import 'package:mediconnect/core/services/mock_data_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentsListScreen extends StatefulWidget {
  const AppointmentsListScreen({super.key});

  @override
  State<AppointmentsListScreen> createState() => _AppointmentsListScreenState();
}

class _AppointmentsListScreenState extends State<AppointmentsListScreen> {
  int _selectedTab = 0; // 0 for Upcoming, 1 for Completed

  @override
  Widget build(BuildContext context) {
    final appointments = MockDataService.appointments.where((a) {
      if (_selectedTab == 0) return a.status == 'Upcoming';
      return a.status == 'Completed';
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
          SizedBox(width: 8.w),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(AppSpacing.s24),
            child: _buildTabToggle(),
          ),
          Expanded(
            child: appointments.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.s24),
                    itemCount: appointments.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AppointmentCard(
                        appointment: appointments[index],
                        onTap: () {},
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabToggle() {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.cardDark
            : Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          _TabButton(
            label: 'Upcoming',
            isSelected: _selectedTab == 0,
            onTap: () => setState(() => _selectedTab = 0),
          ),
        );
      },
    );
  }

  Widget _buildPastList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildAppointmentCard(
          status: 'Completed',
          statusColor: Color(0xFF8E8E93),
          date: 'Sep 15, 2023 - 09:00 AM',
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy_rounded, size: 64.sp, color: AppColors.textSecondaryLight.withOpacity(0.3)),
          SizedBox(height: 16.h),
          Text(
            'No appointments found',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondaryLight),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textSecondaryLight,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
