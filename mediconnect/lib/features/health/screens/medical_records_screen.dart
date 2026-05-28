import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class MedicalRecordsScreen extends StatelessWidget {
  const MedicalRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medical Records')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildCategoryGrid(),
            const SizedBox(height: 30),
            _buildRecentDocuments(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_a_photo, color: Colors.white),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    final categories = [
      {'name': 'Lab Reports', 'icon': Icons.biotech, 'color': Colors.blue},
      {'name': 'Prescriptions', 'icon': Icons.description, 'color': Colors.green},
      {'name': 'Imaging', 'icon': Icons.visibility, 'color': Colors.orange},
      {'name': 'Vaccinations', 'icon': Icons.vaccines, 'color': Colors.purple},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 1.5,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: (categories[index]['color'] as Color).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(categories[index]['icon'] as IconData, color: categories[index]['color'] as Color),
              const SizedBox(height: 10),
              Text(categories[index]['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecentDocuments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recent Documents', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 15),
        _buildDocumentItem('Blood Test Results', 'Oct 10, 2023', 'PDF', Colors.red),
        _buildDocumentItem('Chest X-Ray', 'Oct 05, 2023', 'IMG', Colors.blue),
        _buildDocumentItem('COVID-19 Vaccine', 'Sep 20, 2023', 'PDF', Colors.green),
      ],
    );
  }

  Widget _buildDocumentItem(String title, String date, String type, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.insert_drive_file, color: color),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(date, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(5)),
            child: Text(type, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
