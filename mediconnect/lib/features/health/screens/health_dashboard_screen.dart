import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthDashboardScreen extends StatelessWidget {
  const HealthDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Health', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildActivitySection(context),
            SizedBox(height: 32.h),
            Text('Daily Vitals', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
            SizedBox(height: 16.h),
            _buildVitalsGrid(context),
            SizedBox(height: 32.h),
            _buildInsightCard(context),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildActivitySection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MediCard(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Weekly Activity', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
              Icon(Icons.more_horiz_rounded, color: colorScheme.onSurfaceVariant),
            ],
          ),
          SizedBox(height: 24.h),
          SizedBox(
            height: 160.h,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3), FlSpot(1, 1), FlSpot(2, 4), FlSpot(3, 2), FlSpot(4, 5), FlSpot(5, 3), FlSpot(6, 4),
                    ],
                    isCurved: true,
                    color: colorScheme.primary,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [colorScheme.primary.withOpacity(0.2), colorScheme.primary.withOpacity(0.0)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16.w,
      crossAxisSpacing: 16.w,
      childAspectRatio: 1.1,
      children: [
        _buildVitalCard(context, 'Heart Rate', '72 bpm', Icons.favorite_rounded, Colors.red),
        _buildVitalCard(context, 'Blood Pressure', '120/80', Icons.speed_rounded, Colors.blue),
        _buildVitalCard(context, 'Sleep', '7h 20m', Icons.bedtime_rounded, Colors.indigo),
        _buildVitalCard(context, 'Steps', '8,432', Icons.directions_walk_rounded, Colors.orange),
      ],
    );
  }

  Widget _buildVitalCard(BuildContext context, String title, String value, IconData icon, Color color) {
    final colorScheme = Theme.of(context).colorScheme;
    return MediCard(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 20.sp),
              ),
              Icon(Icons.arrow_forward_ios_rounded, size: 12.sp, color: colorScheme.onSurfaceVariant),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: colorScheme.onSurface)),
              Text(title, style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12.sp)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FadeInUp(
      child: Container(
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: colorScheme.inverseSurface,
          borderRadius: DesignSystem.borderL,
          boxShadow: DesignSystem.premiumShadow,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(color: colorScheme.onInverseSurface.withOpacity(0.1), borderRadius: DesignSystem.borderM),
              child: Icon(Icons.auto_awesome_rounded, color: colorScheme.onInverseSurface, size: 28.sp),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('AI Health Insight', style: TextStyle(color: colorScheme.onInverseSurface, fontWeight: FontWeight.bold, fontSize: 16.sp)),
                  SizedBox(height: 4.h),
                  Text(
                    'You reached your steps goal 5 times this week. Keep it up!',
                    style: TextStyle(color: colorScheme.onInverseSurface.withOpacity(0.7), fontSize: 13.sp, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
