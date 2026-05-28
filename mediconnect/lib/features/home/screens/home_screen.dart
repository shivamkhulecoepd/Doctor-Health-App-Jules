import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:mediconnect/core/widgets/glass_card.dart';
import 'package:animate_do/animate_do.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            backgroundColor: AppColors.background,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good Morning,',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
                      Text('Sarah Adams',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  IconButton(
                    onPressed: () => context.push('/notifications'),
                    icon: const Badge(
                      label: Text('3'),
                      child: Icon(Icons.notifications_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroCard(context),
                  const SizedBox(height: 30),
                  _buildQuickActions(context),
                  const SizedBox(height: 30),
                  _buildVitalsSnapshot(context),
                  const SizedBox(height: 30),
                  _buildRecommendations(context),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    return FadeInRight(
      child: GlassCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=dr1'),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Dr. Marcus Horizon', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('Cardiologist • 10:30 AM Today', style: TextStyle(color: AppColors.textSecondary.withOpacity(0.8))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.push('/video-call'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Join Consultation'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {'icon': Icons.calendar_month, 'label': 'Book', 'color': Colors.blue},
      {'icon': Icons.medical_services, 'label': 'Records', 'color': Colors.green},
      {'icon': Icons.medication, 'label': 'Prescriptions', 'color': Colors.orange},
      {'icon': Icons.warning_amber, 'label': 'Emergency', 'color': Colors.red, 'route': '/sos'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (actions[index]['route'] != null) {
              context.push(actions[index]['route'] as String);
            }
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (actions[index]['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(actions[index]['icon'] as IconData, color: actions[index]['color'] as Color),
              ),
              const SizedBox(height: 8),
              Text(actions[index]['label'] as String, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVitalsSnapshot(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Health Vitals', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: const Text('See All')),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildVitalCard('Heart Rate', '82 bpm', Icons.favorite, Colors.red),
              _buildVitalCard('Sleep', '7h 20m', Icons.bedtime, Colors.indigo),
              _buildVitalCard('Steps', '8,432', Icons.directions_walk, Colors.orange),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVitalCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(title, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recommended Doctors', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network('https://i.pravatar.cc/100?u=doc$index', width: 80, height: 80, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dr. Sarah Jenkins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('Dermatologist • ★ 4.8', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                        SizedBox(height: 5),
                        Text('Available: Mon, 12 Oct', style: TextStyle(color: AppColors.secondary, fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios, size: 16)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
