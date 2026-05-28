import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Symptom Checker')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Where do you feel discomfort?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 20),
            // Placeholder for Body Map SVG
            Container(
              height: 300,
              width: 200,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: const Center(child: Icon(Icons.accessibility_new, size: 150, color: AppColors.primary)),
            ),
            const SizedBox(height: 30),
            _buildSymptomSelection(),
            const SizedBox(height: 30),
            _buildSeveritySlider(),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Analyze Symptoms'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomSelection() {
    final symptoms = ['Headache', 'Fever', 'Cough', 'Chest Pain', 'Nausea', 'Fatigue'];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: symptoms.map((symptom) {
        final isSelected = _selectedSymptoms.contains(symptom);
        return FilterChip(
          label: Text(symptom),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedSymptoms.add(symptom);
              } else {
                _selectedSymptoms.remove(symptom);
              }
            });
          },
          selectedColor: AppColors.primary,
          labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary),
        );
      }).toList(),
    );
  }

  Widget _buildSeveritySlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Severity', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('${(_severity * 10).toInt()}/10', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.error)),
          ],
        ),
        Slider(
          value: _severity,
          onChanged: (v) => setState(() => _severity = v),
          activeColor: Color.lerp(Colors.green, Colors.red, _severity),
          inactiveColor: Colors.grey[200],
        ),
      ],
    );
  }
}
