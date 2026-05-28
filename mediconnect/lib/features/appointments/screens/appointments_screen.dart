import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:animate_do/animate_do.dart';

class AppointmentsListScreen extends StatefulWidget {
  const AppointmentsListScreen({super.key});

  @override
  State<AppointmentsListScreen> createState() => _AppointmentsListScreenState();
}

class _AppointmentsListScreenState extends State<AppointmentsListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingList(),
          _buildPastList(),
          _buildCancelledList(),
        ],
      ),
    );
  }

  Widget _buildUpcomingList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 3,
      itemBuilder: (context, index) {
        return FadeInLeft(
          delay: Duration(milliseconds: index * 100),
          child: _buildAppointmentCard(
            status: 'Confirmed',
            statusColor: AppColors.secondary,
            date: 'Oct 12, 2023 - 10:30 AM',
          ),
        );
      },
    );
  }

  Widget _buildPastList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildAppointmentCard(
          status: 'Completed',
          statusColor: AppColors.textSecondary,
          date: 'Sep 15, 2023 - 09:00 AM',
        );
      },
    );
  }

  Widget _buildCancelledList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text('No cancelled appointments', style: TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard({required String status, required Color statusColor, required String date}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network('https://i.pravatar.cc/100?u=doc1', width: 60, height: 60, fit: BoxFit.cover),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Dr. Marcus Horizon', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Text('Cardiologist', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const Divider(height: 30),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Text(date, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              const Spacer(),
              const Icon(Icons.videocam, size: 18, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Reschedule'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
