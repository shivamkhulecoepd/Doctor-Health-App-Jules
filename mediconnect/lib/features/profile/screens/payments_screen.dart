import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentsBillingScreen extends StatelessWidget {
  const PaymentsBillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Payments')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.s24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalSpentCard(),
            SizedBox(height: AppSpacing.s32),
            _buildSectionHeader('Saved Cards'),
            SizedBox(height: AppSpacing.s16),
            _buildCardItem('**** **** **** 4242', 'Visa', isDark),
            SizedBox(height: AppSpacing.s32),
            _buildSectionHeader('Transaction History'),
            SizedBox(height: AppSpacing.s16),
            _buildTransactionItem('Dr. Marcus Horizon', 'Oct 22, 2023', '\$50.00', 'Paid', isDark),
            _buildTransactionItem('Dr. Maria Elena', 'Oct 15, 2023', '\$75.00', 'Paid', isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSpentCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Spent this Month', style: TextStyle(color: Colors.white70, fontSize: 13)),
          SizedBox(height: 8.h),
          Text('\$125.00', style: TextStyle(color: Colors.white, fontSize: 32.sp, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold));
  }

  Widget _buildCardItem(String number, String type, bool isDark) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: isDark ? null : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          const Icon(Icons.credit_card_rounded, color: AppColors.primary),
          SizedBox(width: 16.w),
          Text(number, style: const TextStyle(fontWeight: FontWeight.w600)),
          const Spacer(),
          Text(type, style: const TextStyle(color: AppColors.textSecondaryLight)),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String name, String date, String amount, String status, bool isDark) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(date, style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 12.sp)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
              Text(status, style: const TextStyle(color: AppColors.success, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
