import "package:mediconnect/shared/widgets/reusable_widgets.dart";
import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WritePrescriptionScreen extends StatefulWidget {
  final String appointmentId;
  const WritePrescriptionScreen({super.key, required this.appointmentId});

  @override
  State<WritePrescriptionScreen> createState() => _WritePrescriptionScreenState();
}

class _WritePrescriptionScreenState extends State<WritePrescriptionScreen> {
  final List<Map<String, String>> _medicines = [
    {'name': 'Amoxicillin', 'dosage': '500mg', 'freq': '2x daily'}
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Write Prescription')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.s24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPatientHeader(isDark),
            SizedBox(height: AppSpacing.s32),
            const Text('Diagnosis', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12.h),
            const AppSearchBar(hintText: 'Enter diagnosis...'),
            SizedBox(height: AppSpacing.s32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Medications', style: TextStyle(fontWeight: FontWeight.bold)),
                TextButton.icon(
                  onPressed: () => setState(() => _medicines.add({'name': '', 'dosage': '', 'freq': ''})),
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Add'),
                ),
              ],
            ),
            ..._medicines.map((m) => _buildMedicationRow(m, isDark)),
            SizedBox(height: AppSpacing.s32),
            const Text('Additional Notes', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12.h),
            _buildNotesField(isDark),
            SizedBox(height: 48.h),
            PrimaryButton(text: 'Send to Patient', onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientHeader(bool isDark) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 24, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=p1')),
          SizedBox(width: 16.w),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sarah Adams', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('24 Years • Female', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationRow(Map<String, String> med, bool isDark) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : const Color(0xFFF4F6FF),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(child: Text(med['name']!.isEmpty ? 'Select Medicine' : med['name']!, style: const TextStyle(fontWeight: FontWeight.w500))),
          Text(med['dosage']!, style: const TextStyle(color: AppColors.textSecondaryLight)),
          SizedBox(width: 12.w),
          const Icon(Icons.edit_outlined, size: 16, color: AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildNotesField(bool isDark) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : const Color(0xFFF0F0F5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: const TextField(
        maxLines: 3,
        decoration: InputDecoration(hintText: 'Enter advice for patient...', border: InputBorder.none),
      ),
    );
  }
}
