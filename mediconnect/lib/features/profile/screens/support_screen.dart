import "package:mediconnect/core/widgets/glass_card.dart";
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediconnect/core/theme/design_system.dart';
import 'package:mediconnect/core/widgets/glass_card.dart';
import 'package:animate_do/animate_do.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            FadeInDown(child: _buildSearchBar(context)),
            SizedBox(height: 32.h),
            FadeInUp(child: _buildFAQSection(context)),
            SizedBox(height: 32.h),
            FadeInUp(delay: const Duration(milliseconds: 200), child: _buildContactOptions(context)),
            SizedBox(height: 100.h),
          ],
        ),
      ),
      floatingActionButton: FadeInRight(
        child: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: colorScheme.primary,
          elevation: 8,
          icon: const Icon(Icons.chat_bubble_rounded, color: Colors.white),
          label: const Text('Live Chat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GlassCard(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      borderRadius: BorderRadius.circular(28.r),
      child: TextField(
        style: TextStyle(color: colorScheme.onSurface, fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: 'How can we help you?',
          hintStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14.sp),
          prefixIcon: Icon(Icons.search_rounded, color: colorScheme.primary, size: 22.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
      ),
    );
  }

  Widget _buildFAQSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Frequently Asked Questions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: colorScheme.onSurface)),
        SizedBox(height: 16.h),
        _buildExpansionTile(context, 'How to book an appointment?', 'Navigate to the Doctor Search, select a specialist, and follow the booking steps.'),
        _buildExpansionTile(context, 'Is my medical data secure?', 'MediConnect uses end-to-end encryption for all health records and consultations.'),
        _buildExpansionTile(context, 'Can I reschedule a call?', 'Yes, go to Appointment Details and select "Reschedule" up to 2 hours before the start.'),
      ],
    );
  }

  Widget _buildExpansionTile(BuildContext context, String title, String content) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GlassCard(
        padding: EdgeInsets.zero,
        child: ExpansionTile(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp, color: colorScheme.onSurface)),
          iconColor: colorScheme.primary,
          collapsedIconColor: colorScheme.onSurfaceVariant,
          shape: const RoundedRectangleBorder(side: BorderSide.none),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Text(content, style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14.sp, height: 1.5)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContactOptions(BuildContext context) {
    return Row(
      children: [
        _buildContactCard(context, 'Email Support', Icons.mail_outline_rounded, Colors.blue),
        SizedBox(width: 16.w),
        _buildContactCard(context, 'Call Center', Icons.headset_mic_outlined, Colors.green),
      ],
    );
  }

  Widget _buildContactCard(BuildContext context, String title, IconData icon, Color color) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: GlassCard(
        padding: EdgeInsets.all(20.r),
        onTap: () {},
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 28.sp),
            ),
            SizedBox(height: 12.h),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }
}
