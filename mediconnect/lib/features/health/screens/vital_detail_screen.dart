import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class VitalDetailView extends StatelessWidget {
  final String type;
  const VitalDetailView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('$type Analysis', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_rounded)),
          SizedBox(width: 8.w),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(AppSpacing.s24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(child: _buildChartCard(context, isDark)),
            SizedBox(height: AppSpacing.s32),
            SectionHeader(title: 'Activity History'),
            SizedBox(height: AppSpacing.s16),
            _buildHistoryList(context, isDark),
            SizedBox(height: AppSpacing.s32),
            FadeInUp(child: _buildInsightsCard(context, isDark)),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: isDark ? null : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Weekly View', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10.r)),
                child: Text('Avg: 78', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12.sp)),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          SizedBox(
            height: 200.h,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (v) => FlLine(color: AppColors.textSecondaryLight.withOpacity(0.1), strokeWidth: 1)),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [FlSpot(0, 75), FlSpot(1, 82), FlSpot(2, 70), FlSpot(3, 85), FlSpot(4, 78), FlSpot(5, 80), FlSpot(6, 72)],
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 4,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: true, gradient: LinearGradient(colors: [AppColors.primary.withOpacity(0.2), AppColors.primary.withOpacity(0)])),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context, bool isDark) {
    return Column(
      children: [
        _buildHistoryItem('Oct 22', '82 bpm', 'Normal', isDark),
        _buildHistoryItem('Oct 21', '88 bpm', 'High', isDark),
        _buildHistoryItem('Oct 20', '76 bpm', 'Normal', isDark),
      ],
    );
  }

  Widget _buildHistoryItem(String date, String value, String status, bool isDark) {
    final statusColor = status == 'Normal' ? AppColors.success : AppColors.error;
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
          Text(date, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: AppColors.primary)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8.r)),
            child: Text(status, style: TextStyle(color: statusColor, fontSize: 11.sp, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsCard(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
            child: Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Health Insight', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.sp)),
                SizedBox(height: 4.h),
                Text('Your $type is more stable this week compared to last.', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
