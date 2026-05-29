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
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Checker', style: TextStyle(color: colorScheme.onSurface)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Where do you feel discomfort?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorScheme.onSurface)),
            const SizedBox(height: 20),
            // Placeholder for Body Map SVG
            Container(
              height: 300,
              width: 200,
              decoration: BoxDecoration(color: colorScheme.surface, borderRadius: BorderRadius.circular(20)),
              child: Center(child: Icon(Icons.accessibility_new, size: 150, color: colorScheme.primary)),
            ),
            const SizedBox(height: 30),
            _buildSymptomSelection(context),
            const SizedBox(height: 30),
            _buildSeveritySlider(context),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
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

  Widget _buildSymptomSelection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
          selectedColor: colorScheme.primary,
          labelStyle: TextStyle(color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface),
          backgroundColor: colorScheme.surface,
          checkmarkColor: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
        );
      }).toList(),
    );
  }

  Widget _buildSeveritySlider(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Severity', style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
            Text('${(_severity * 10).toInt()}/10', style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.error)),
          ],
        ),
        Slider(
          value: _severity,
          onChanged: (v) => setState(() => _severity = v),
          activeColor: Color.lerp(Colors.green, Colors.red, _severity),
          inactiveColor: colorScheme.outlineVariant,
        ),
      ],
    );
  }
}
