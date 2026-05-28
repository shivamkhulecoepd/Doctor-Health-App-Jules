import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:animate_do/animate_do.dart';

class DoctorSearchScreen extends StatefulWidget {
  const DoctorSearchScreen({super.key});

  @override
  State<DoctorSearchScreen> createState() => _DoctorSearchScreenState();
}

class _DoctorSearchScreenState extends State<DoctorSearchScreen> {
  final List<String> _filters = ['All', 'Cardiology', 'Dermatology', 'Neurology', 'Pediatrics'];
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Doctors'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search doctor, specialty...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                    suffixIcon: const Icon(Icons.tune, color: AppColors.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: _filters.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedFilter == index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ChoiceChip(
                        label: Text(_filters[index]),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() => _selectedFilter = index);
                        },
                        selectedColor: AppColors.primary,
                        labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 5,
        itemBuilder: (context, index) {
          return FadeInUp(
            delay: Duration(milliseconds: index * 100),
            child: _buildDoctorCard(context, index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Map View'),
        icon: const Icon(Icons.map_outlined),
        backgroundColor: AppColors.textPrimary,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => context.push('/doctor/doc_$index'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network('https://i.pravatar.cc/150?u=doc$index', width: 100, height: 100, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Dr. Maria Elena', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const Text('Psychologist • Hospital San Jose', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppColors.accent, size: 16),
                      const SizedBox(width: 4),
                      const Text('4.9', style: TextStyle(fontWeight: FontWeight.bold)),
                      const Text(' (120 reviews)', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Next: Tomorrow, 09:00 AM', style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
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
