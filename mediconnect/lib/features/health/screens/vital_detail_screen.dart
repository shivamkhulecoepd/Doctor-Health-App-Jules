import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';

class VitalDetailView extends StatelessWidget {
  final String type;
  const VitalDetailView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$type Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainChart(),
            const SizedBox(height: 30),
            const Text('History', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 15),
            _buildHistoryItem('Oct 12', '82 bpm', 'Normal'),
            _buildHistoryItem('Oct 11', '85 bpm', 'Slightly High'),
            _buildHistoryItem('Oct 10', '78 bpm', 'Normal'),
            _buildHistoryItem('Oct 09', '80 bpm', 'Normal'),
            const SizedBox(height: 40),
            _buildGoalSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainChart() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 80),
                FlSpot(1, 85),
                FlSpot(2, 78),
                FlSpot(3, 82),
                FlSpot(4, 88),
                FlSpot(5, 84),
                FlSpot(6, 80),
              ],
              isCurved: true,
              color: AppColors.primary,
              barWidth: 4,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: true, color: AppColors.primary.withOpacity(0.1)),
            ),
          ],
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(String date, String value, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
          Text(status, style: TextStyle(color: status == 'Normal' ? AppColors.secondary : Colors.orange, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildGoalSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your Goal', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Maintain 70-80 bpm', style: TextStyle(color: AppColors.textSecondary)),
              Text('85%', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(value: 0.85, backgroundColor: Colors.white, valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary)),
        ],
      ),
    );
  }
}
