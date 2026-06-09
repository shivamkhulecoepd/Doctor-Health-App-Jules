import "package:mediconnect/core/widgets/glass_card.dart";
import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/premium_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  State<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  double _severity = 0.0;
  final List<String> _selectedSymptoms = [];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Checker', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            FadeInDown(
              child: Text(
                'Where do you feel discomfort?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: colorScheme.onSurface),
              ),
            ),
            SizedBox(height: 32.h),
            FadeIn(
              duration: const Duration(seconds: 1),
              child: GlassCard(
                padding: EdgeInsets.all(32.r),
                child: Hero(
                  tag: 'body_map',
                  child: Icon(Icons.accessibility_new_rounded, size: 240.sp, color: colorScheme.primary),
                ),
              ),
            ),
            SizedBox(height: 32.h),
            FadeInUp(child: _buildSymptomSelection(context)),
            SizedBox(height: 32.h),
            FadeInUp(delay: const Duration(milliseconds: 200), child: _buildSeveritySlider(context)),
            SizedBox(height: 48.h),
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: MediButton(
                text: 'Analyze Symptoms',
                onPressed: () {},
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomSelection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final symptoms = ['Headache', 'Fever', 'Cough', 'Chest Pain', 'Nausea', 'Fatigue'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Common Symptoms', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: colorScheme.onSurface)),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: symptoms.map((symptom) {
            final isSelected = _selectedSymptoms.contains(symptom);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedSymptoms.remove(symptom);
                  } else {
                    _selectedSymptoms.add(symptom);
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected ? colorScheme.primary : colorScheme.surface,
                  borderRadius: DesignSystem.borderM,
                  border: Border.all(color: isSelected ? colorScheme.primary : colorScheme.outlineVariant),
                  boxShadow: isSelected ? DesignSystem.softShadow : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      Icon(Icons.check_rounded, size: 14.sp, color: colorScheme.onPrimary),
                      SizedBox(width: 8.w),
                    ],
                    Text(
                      symptom,
                      style: TextStyle(
                        color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSeveritySlider(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final severityColor = Color.lerp(Colors.green, Colors.red, _severity) ?? Colors.green;

    return GlassCard(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pain Severity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: colorScheme.onSurface)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(color: severityColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
                child: Text(
                  '${(_severity * 10).toInt()}/10',
                  style: TextStyle(fontWeight: FontWeight.bold, color: severityColor, fontSize: 14.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: severityColor,
              inactiveTrackColor: colorScheme.outlineVariant,
              thumbColor: Colors.white,
              overlayColor: severityColor.withOpacity(0.2),
            ),
            child: Slider(
              value: _severity,
              onChanged: (v) => setState(() => _severity = v),
            ),
          ),
        ],
      ),
    );
  }
}
