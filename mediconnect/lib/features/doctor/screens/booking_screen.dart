import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class BookingFlowScreen extends StatefulWidget {
  final String doctorId;
  const BookingFlowScreen({super.key, required this.doctorId});

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  int _currentStep = 0;
  String _selectedSlot = '';
  final List<String> _slots = ['09:00 AM', '10:30 AM', '01:00 PM', '02:30 PM', '04:00 PM'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildStepContent(),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
      child: Row(
        children: List.generate(3, (index) {
          final isActive = _currentStep >= index;
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : Colors.grey[300],
                    shape: BoxShape.circle,
                    boxShadow: isActive ? DesignSystem.softShadow : null,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (index < 2)
                  Expanded(
                    child: Container(
                      height: 2.h,
                      color: _currentStep > index ? AppColors.primary : Colors.grey[300],
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0: return _buildDateTimeStep();
      case 1: return _buildConsultationTypeStep();
      case 2: return _buildPaymentStep();
      default: return Container();
    }
  }

  Widget _buildDateTimeStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Date', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 16.h),
          MediCard(
            padding: EdgeInsets.zero,
            child: CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 30)),
              onDateChanged: (date) {},
            ),
          ),
          SizedBox(height: 32.h),
          Text('Available Time Slots', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: _slots.map((slot) {
              final isSelected = _selectedSlot == slot;
              return GestureDetector(
                onTap: () => setState(() => _selectedSlot = slot),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.white,
                    borderRadius: DesignSystem.borderM,
                    border: Border.all(color: isSelected ? AppColors.primary : Colors.grey[200]!),
                    boxShadow: isSelected ? DesignSystem.softShadow : null,
                  ),
                  child: Text(
                    slot,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildConsultationTypeStep() {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Consultation Type', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 24.h),
          _buildTypeCard('In-Clinic Visit', 'Physical consultation at hospital', Icons.home_work_rounded, true),
          SizedBox(height: 16.h),
          _buildTypeCard('Online Consultation', 'Secure video call via app', Icons.videocam_rounded, false),
        ],
      ),
    );
  }

  Widget _buildTypeCard(String title, String subtitle, IconData icon, bool isSelected) {
    return MediCard(
      padding: EdgeInsets.all(20.r),
      onTap: () {},
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.background,
              borderRadius: DesignSystem.borderM,
            ),
            child: Icon(icon, color: isSelected ? Colors.white : AppColors.textSecondary, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                Text(subtitle, style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp)),
              ],
            ),
          ),
          if (isSelected) Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 24.sp),
        ],
      ),
    );
  }

  Widget _buildPaymentStep() {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 16.h),
          MediCard(
            child: Column(
              children: [
                _buildSummaryRow('Consultation Fee', '\$50.00'),
                SizedBox(height: 12.h),
                _buildSummaryRow('Service Fee', '\$2.50'),
                Divider(height: 32.h),
                _buildSummaryRow('Total', '\$52.50', isTotal: true),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          Text('Payment Method', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 16.h),
          MediCard(
            onTap: () {},
            child: Row(
              children: [
                const Icon(Icons.credit_card_rounded, color: AppColors.primary),
                SizedBox(width: 16.w),
                const Text('**** **** **** 4242', style: TextStyle(fontWeight: FontWeight.w600)),
                const Spacer(),
                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: isTotal ? AppColors.textPrimary : AppColors.textSecondary, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        Text(value, style: TextStyle(color: isTotal ? AppColors.primary : AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: isTotal ? 18.sp : 14.sp)),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 40.h),
      decoration: BoxDecoration(color: Colors.white, boxShadow: DesignSystem.softShadow),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: MediButton(
                  text: 'Back',
                  isPrimary: false,
                  onPressed: () => setState(() => _currentStep--),
                ),
              ),
            ),
          Expanded(
            flex: 2,
            child: MediButton(
              text: _currentStep == 2 ? 'Confirm & Pay' : 'Next Step',
              onPressed: () {
                if (_currentStep < 2) {
                  setState(() => _currentStep++);
                } else {
                  _showSuccessDialog();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
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
                style: TextStyle(color: AppColors.textSecondary, height: 1.5, fontSize: 14.sp),
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
