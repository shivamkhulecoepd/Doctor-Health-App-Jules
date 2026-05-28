import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:animate_do/animate_do.dart';

class NotificationsCenterScreen extends StatelessWidget {
  const NotificationsCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(onPressed: () {}, child: const Text('Mark all read')),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          final isCritical = index == 0;
          return FadeInUp(
            delay: Duration(milliseconds: index * 100),
            child: Dismissible(
              key: Key('notif_$index'),
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                color: AppColors.error,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: isCritical ? const Border(left: BorderSide(color: AppColors.error, width: 4)) : null,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: (isCritical ? AppColors.error : AppColors.primary).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isCritical ? Icons.warning_amber_rounded : Icons.notifications_none_rounded,
                        color: isCritical ? AppColors.error : AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isCritical ? 'Critical Alert' : 'Appointment Reminder',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const Text('2m ago', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Your heart rate exceeded 100bpm while resting. Please check your vitals.',
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
