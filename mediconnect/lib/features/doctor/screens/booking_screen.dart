import "package:mediconnect/shared/widgets/reusable_widgets.dart";
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/core/models/app_models.dart';
import 'package:mediconnect/core/providers/app_providers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class BookingFlowScreen extends ConsumerStatefulWidget {
  final String doctorId;
  const BookingFlowScreen({super.key, required this.doctorId});

  @override
  ConsumerState<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends ConsumerState<BookingFlowScreen> {
  int _currentStep = 0;
  DateTime _selectedDate = DateTime.now();
  String _selectedTime = '09:00 AM';
  String _consultationType = 'Video call';

  final List<String> _timeSlots = ['09:00 AM', '10:00 AM', '11:00 AM', '01:00 PM', '02:00 PM', '03:00 PM', '04:00 PM'];

  @override
  Widget build(BuildContext context) {
    final doctor = ref.watch(doctorsProvider).firstWhere((d) => d.id == widget.doctorId);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppSpacing.s24),
              child: _buildStepContent(doctor, isDark),
            ),
          ),
          _buildBottomNav(doctor),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          final isActive = _currentStep >= index;
          return Container(
            width: 32.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : AppColors.textSecondaryLight.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2.r),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent(Doctor doctor, bool isDark) {
    switch (_currentStep) {
      case 0: return _buildDateStep(isDark);
      case 1: return _buildTimeStep(isDark);
      case 2: return _buildConsultationTypeStep(isDark);
      case 3: return _buildPatientDetailsStep(isDark);
      case 4: return _buildConfirmStep(doctor, isDark);
      default: return Container();
    }
  }

  Widget _buildDateStep(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Date', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 24.h),
        _buildDateSelector(isDark),
      ],
    );
  }

  Widget _buildTimeStep(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Time', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 24.h),
        _buildTimeGrid(isDark),
      ],
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

  Widget _buildConsultationTypeStep(bool isDark) {
    final types = ['In-person', 'Video call', 'Phone call'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Consultation Type', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 24.h),
        Wrap(
          spacing: 12.w,
          children: types.map((type) => ChoiceChip(
            label: Text(type),
            selected: _consultationType == type,
            onSelected: (s) => setState(() => _consultationType = type),
            selectedColor: AppColors.primary,
            labelStyle: TextStyle(color: _consultationType == type ? Colors.white : null),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildPatientDetailsStep(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Patient Details', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 24.h),
        const AppSearchBar(hintText: 'Describe your symptoms...'),
        SizedBox(height: 16.h),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.upload_file_rounded),
          label: const Text('Upload Medical Document (Optional)'),
          style: OutlinedButton.styleFrom(minimumSize: Size(double.infinity, 56.h)),
        ),
      ],
    );
  }

  Widget _buildConfirmStep(Doctor doctor, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Confirm and Pay', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 24.h),
        _buildDoctorMiniCard(doctor, isDark),
        SizedBox(height: 24.h),
        const SectionHeader(title: 'Payment Method'),
        ListTile(
          leading: const Icon(Icons.credit_card, color: AppColors.primary),
          title: const Text('**** **** **** 4242'),
          trailing: const Icon(Icons.check_circle, color: AppColors.primary),
          tileColor: isDark ? AppColors.cardDark : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      ],
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

  Widget _buildBottomNav(Doctor doctor) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 40.h),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: OutlinedButton(
                  onPressed: () => setState(() => _currentStep--),
                  child: const Text('Back'),
                ),
              ),
            ),
          Expanded(
            flex: 2,
            child: PrimaryButton(
              text: _currentStep == 4 ? 'Confirm & Pay' : 'Continue',
              onPressed: () {
                if (_currentStep < 4) {
                  setState(() => _currentStep++);
                } else {
                  _finishBooking(doctor);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _finishBooking(Doctor doctor) {
    final newAppointment = Appointment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      doctorId: widget.doctorId,
      doctorName: doctor.name,
      doctorSpecialty: doctor.specialty,
      doctorImageUrl: doctor.imageUrl,
      dateTime: _selectedDate.copyWith(
        hour: int.parse(_selectedTime.split(':')[0]) + (_selectedTime.contains('PM') && !_selectedTime.startsWith('12') ? 12 : 0),
        minute: int.parse(_selectedTime.split(':')[1].split(' ')[0]),
      ),
      status: 'Upcoming',
    );
    ref.read(appointmentsProvider.notifier).update((state) => [newAppointment, ...state]);
    _showSuccessDialog(context);
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 40),
            ),
            SizedBox(height: 24.h),
            const Text('Booking Successful!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8.h),
            Text('Your appointment is confirmed.', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 14.sp)),
            SizedBox(height: 24.h),
            PrimaryButton(text: 'Done', onPressed: () => context.go('/home')),
          ],
        ),
      ),
    );
  }
}
