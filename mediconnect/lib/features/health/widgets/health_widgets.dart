import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class HealthGoalsWidget extends StatelessWidget {
  const HealthGoalsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Health Goals', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 15),
        _buildGoalItem('Daily Steps', 0.8, '8,000 / 10,000', Colors.orange),
        _buildGoalItem('Water Intake', 0.4, '2 / 5 Glasses', Colors.blue),
        _buildGoalItem('Sleep Quality', 0.9, '7.5 / 8 Hours', Colors.indigo),
      ],
    );
  }

  Widget _buildGoalItem(String title, double progress, String detail, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(detail, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(value: progress, backgroundColor: color.withOpacity(0.1), valueColor: AlwaysStoppedAnimation<Color>(color), borderRadius: BorderRadius.circular(5)),
        ],
      ),
    );
  }
}

class MedicationRemindersWidget extends StatelessWidget {
  const MedicationRemindersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Medication Today', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 15),
        _buildPillItem('Amoxicillin', '09:00 AM', true),
        _buildPillItem('Vitamin D', '01:00 PM', false),
        _buildPillItem('Magnesium', '09:00 PM', false),
      ],
    );
  }

  Widget _buildPillItem(String name, String time, bool isTaken) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: (isTaken ? Colors.green : Colors.orange).withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(Icons.medication, color: isTaken ? Colors.green : Colors.orange, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(time, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Checkbox(value: isTaken, onChanged: (v) {}, activeColor: AppColors.secondary, shape: const CircleBorder()),
        ],
      ),
    );
  }
}
