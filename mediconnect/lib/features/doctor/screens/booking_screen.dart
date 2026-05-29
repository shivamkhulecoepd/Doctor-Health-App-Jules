import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class BookingFlowScreen extends StatefulWidget {
  final String doctorId;
  const BookingFlowScreen({super.key, required this.doctorId});

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedTime = '09:00 AM';

  final List<String> _timeSlots = [
    '09:00 AM', '10:00 AM', '11:00 AM', '01:00 PM', '02:00 PM', '03:00 PM', '04:00 PM'
  ];

  @override
  Widget build(BuildContext context) {
    final doctor = MockDataService.doctors.firstWhere((d) => d.id == widget.doctorId);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.s24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoctorMiniCard(doctor, isDark),
            SizedBox(height: AppSpacing.s32),
            Text('Select Date', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
            SizedBox(height: 16.h),
            _buildDateSelector(isDark),
            SizedBox(height: AppSpacing.s32),
            Text('Select Time', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
            SizedBox(height: 16.h),
            _buildTimeGrid(isDark),
            SizedBox(height: 48.h),
            PrimaryButton(
              text: 'Confirm Booking',
              onPressed: () => _showSuccessDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorMiniCard(doctor, bool isDark) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: isDark ? null : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 24.r, backgroundImage: NetworkImage(doctor.imageUrl)),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(doctor.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
              Text(doctor.specialty, style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 13.sp)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector(bool isDark) {
    return SizedBox(
      height: 90.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 14,
        itemBuilder: (context, index) {
          final date = DateTime.now().add(Duration(days: index));
          final isSelected = _selectedDate.day == date.day;
          return GestureDetector(
            onTap: () => setState(() => _selectedDate = date),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 64.w,
              margin: EdgeInsets.only(right: 12.w),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : (isDark ? AppColors.cardDark : const Color(0xFFF4F6FF)),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat('E').format(date), style: TextStyle(color: isSelected ? Colors.white70 : AppColors.textSecondaryLight, fontSize: 12.sp)),
                  SizedBox(height: 4.h),
                  Text(DateFormat('dd').format(date), style: TextStyle(color: isSelected ? Colors.white : null, fontWeight: FontWeight.bold, fontSize: 18.sp)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeGrid(bool isDark) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: _timeSlots.map((time) {
        final isSelected = _selectedTime == time;
        return GestureDetector(
          onTap: () => setState(() => _selectedTime = time),
          child: Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : (isDark ? AppColors.cardDark : Colors.white),
              borderRadius: BorderRadius.circular(12.r),
              border: isSelected ? null : Border.all(color: AppColors.textSecondaryLight.withOpacity(0.2)),
            ),
            alignment: Alignment.center,
            child: Text(
              time,
              style: TextStyle(color: isSelected ? Colors.white : null, fontWeight: FontWeight.w600, fontSize: 13.sp),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: DesignSystem.borderL),
        child: Padding(
          padding: EdgeInsets.all(32.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.network(
                'https://assets10.lottiefiles.com/packages/lf20_afwjh8re.json',
                height: 120.h,
                repeat: false,
              ),
              SizedBox(height: 24.h),
              Text('Appointment Booked!', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 12.h),
              Text(
                'Your consultation with Dr. Maria Elena is confirmed for Oct 12 at 09:00 AM.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF8E8E93), height: 1.5, fontSize: 14.sp),
              ),
              SizedBox(height: 32.h),
              MediButton(
                text: 'Back to Home',
                onPressed: () => context.go('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
