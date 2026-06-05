import "package:mediconnect/core/widgets/glass_card.dart";
import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:mediconnect/core/widgets/glass_card.dart';
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
        title: Text('Health Dashboard', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
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
            FadeInDown(child: _buildHealthScoreCard(context)),
            SizedBox(height: 32.h),
            FadeInUp(child: _buildActivitySection(context)),
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

  Widget _buildHealthScoreCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GlassCard(
      padding: EdgeInsets.all(24.r),
      opacity: 0.1,
      color: colorScheme.primary,
      child: Row(
        children: [
          SizedBox(
            width: 80.w,
            height: 80.w,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 8,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeCap: StrokeCap.round,
                ),
                Center(child: Text('85', style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          SizedBox(width: 24.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Overall Health Score', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 4.h),
                Text('Excellent! You are in the top 10% of users.', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GlassCard(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Weekly Activity', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
                child: Row(
                  children: [
                    Text('This Week', style: TextStyle(color: colorScheme.primary, fontSize: 12.sp, fontWeight: FontWeight.bold)),
                    Icon(Icons.keyboard_arrow_down_rounded, color: colorScheme.primary, size: 16.sp),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          SizedBox(
            height: 180.h,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(color: colorScheme.outlineVariant.withOpacity(0.3), strokeWidth: 1),
                ),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3), FlSpot(1, 1.5), FlSpot(2, 4), FlSpot(3, 2.5), FlSpot(4, 5), FlSpot(5, 3.5), FlSpot(6, 4.5),
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
        _buildVitalCard(context, 'Heart Rate', '72 bpm', Icons.favorite_rounded, Colors.red, 0),
        _buildVitalCard(context, 'Blood Pressure', '120/80', Icons.speed_rounded, Colors.blue, 1),
        _buildVitalCard(context, 'Sleep Quality', '94%', Icons.bedtime_rounded, Colors.indigo, 2),
        _buildVitalCard(context, 'Step Count', '8,432', Icons.directions_walk_rounded, Colors.orange, 3),
      ],
    );
  }

  Widget _buildVitalCard(BuildContext context, String title, String value, IconData icon, Color color, int index) {
    final colorScheme = Theme.of(context).colorScheme;
    return FadeInUp(
      delay: Duration(milliseconds: 200 + (index * 100)),
      child: GlassCard(
        padding: EdgeInsets.all(16.r),
        onTap: () {},
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
                SizedBox(height: 2.h),
                Text(title, style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12.sp)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FadeInUp(
      delay: const Duration(milliseconds: 600),
      child: GlassCard(
        padding: EdgeInsets.all(24.r),
        color: colorScheme.onSurface.withOpacity(0.05),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.1), borderRadius: DesignSystem.borderM),
              child: Icon(Icons.auto_awesome_rounded, color: colorScheme.primary, size: 28.sp),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('AI Health Insight', style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 16.sp)),
                  SizedBox(height: 4.h),
                  Text(
                    'You reached your steps goal 5 times this week. Your cardiovascular health is improving!',
                    style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13.sp, height: 1.4),
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
