import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';

class VitalDetailView extends StatelessWidget {
  final String type;
  const VitalDetailView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('$type Detail', style: TextStyle(color: colorScheme.onSurface)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainChart(context),
            const SizedBox(height: 30),
            Text('History', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorScheme.onSurface)),
            const SizedBox(height: 15),
            _buildHistoryItem(context, 'Oct 12', '82 bpm', 'Normal'),
            _buildHistoryItem(context, 'Oct 11', '85 bpm', 'Slightly High'),
            _buildHistoryItem(context, 'Oct 10', '78 bpm', 'Normal'),
            _buildHistoryItem(context, 'Oct 09', '80 bpm', 'Normal'),
            const SizedBox(height: 40),
            _buildGoalSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMainChart(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: colorScheme.surface, borderRadius: BorderRadius.circular(24)),
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
              color: colorScheme.primary,
              barWidth: 4,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: true, color: colorScheme.primary.withOpacity(0.1)),
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) => Text(value.toInt().toString(), style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 10)),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Text(value.toInt().toString(), style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 10)),
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, String date, String value, String status) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colorScheme.surface, borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: TextStyle(fontWeight: FontWeight.w500, color: colorScheme.onSurface)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary)),
          Text(status, style: TextStyle(color: status == 'Normal' ? colorScheme.secondary : colorScheme.tertiary, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildGoalSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your Goal', style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Maintain 70-80 bpm', style: TextStyle(color: colorScheme.onSurfaceVariant)),
              Text('85%', style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary)),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(value: 0.85, backgroundColor: colorScheme.surface, valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary)),
        ],
      ),
    );
  }
}
