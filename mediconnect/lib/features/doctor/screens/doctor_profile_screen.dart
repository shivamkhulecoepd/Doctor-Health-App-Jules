import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class DoctorProfileScreen extends StatelessWidget {
  final String id;
  const DoctorProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://i.pravatar.cc/300?u=$id',
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dr. Maria Elena', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                          Text('Psychologist • Hospital San Jose', style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                        child: const Icon(Icons.chat_bubble_outline, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('Patients', '1.2k+'),
                      _buildStatItem('Experience', '8 yrs'),
                      _buildStatItem('Rating', '4.9'),
                      _buildStatItem('Reviews', '120'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text('About Doctor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 10),
                  const Text(
                    'Dr. Maria Elena is a highly experienced psychologist specializing in cognitive behavioral therapy. She has worked with numerous patients to overcome anxiety, depression, and stress-related disorders.',
                    style: TextStyle(color: AppColors.textSecondary, height: 1.5),
                  ),
                  const SizedBox(height: 30),
                  const Text('Availability', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 15),
                  _buildAvailabilityCalendar(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: ElevatedButton(
          onPressed: () => context.push('/booking/$id'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('Book Appointment'),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary)),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }

  Widget _buildAvailabilityCalendar() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final dates = ['12', '13', '14', '15', '16', '17'];

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final isSelected = index == 0;
          return Container(
            width: 60,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.grey[100],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(days[index], style: TextStyle(color: isSelected ? Colors.white70 : AppColors.textSecondary, fontSize: 12)),
                Text(dates[index], style: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
