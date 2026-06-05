import "package:mediconnect/shared/widgets/reusable_widgets.dart";
import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorEarningsScreen extends StatelessWidget {
  const DoctorEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Earnings')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.s24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalEarningsCard(),
            SizedBox(height: AppSpacing.s32),
            const Text('Daily Revenue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.h),
            _buildRevenueChart(isDark),
            SizedBox(height: AppSpacing.s32),
            const Text('Recent Payouts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.h),
            _buildPayoutItem('Oct 15, 2023', '\$850.00', 'Success', isDark),
            _buildPayoutItem('Oct 01, 2023', '\$1,120.00', 'Success', isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalEarningsCard() {
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
          const Text('Total Balance', style: TextStyle(color: Colors.white70)),
          Text('\$4,350.00', style: TextStyle(color: Colors.white, fontSize: 32.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 16.h),
          PrimaryButton(text: 'Withdraw Funds', onPressed: () {}, fullWidth: false),
        ],
      ),
    );
  }

  Widget _buildRevenueChart(bool isDark) {
    return Container(
      height: 200.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: BarChart(
        BarChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, color: AppColors.primary, width: 16)]),
            BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 10, color: AppColors.primary, width: 16)]),
            BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 7, color: AppColors.primary, width: 16)]),
            BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 12, color: AppColors.primary, width: 16)]),
            BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 9, color: AppColors.primary, width: 16)]),
          ],
        ),
      ),
    );
  }

  Widget _buildPayoutItem(String date, String amount, String status, bool isDark) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Text('Bank Transfer', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
            ],
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
