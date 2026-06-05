import "package:mediconnect/shared/widgets/reusable_widgets.dart";
import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';
import 'package:mediconnect/core/theme/app_spacing.dart';
import 'package:mediconnect/shared/widgets/reusable_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WriteReviewScreen extends StatefulWidget {
  final String appointmentId;
  const WriteReviewScreen({super.key, required this.appointmentId});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Write a Review')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.s24),
        child: Column(
          children: [
            const CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=d1')),
            SizedBox(height: 16.h),
            const Text('How was your experience with', style: TextStyle(color: AppColors.textSecondaryLight)),
            const Text('Dr. Marcus Horizon', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 32.h),
            _buildStarRating(),
            SizedBox(height: 32.h),
            _buildReviewField(),
            SizedBox(height: 48.h),
            PrimaryButton(text: 'Submit Review', onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () => setState(() => _rating = index + 1),
          icon: Icon(
            index < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
            color: Colors.orange,
            size: 48.sp,
          ),
        );
      }),
    );
  }

  Widget _buildReviewField() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppColors.cardDark : const Color(0xFFF0F0F5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: const TextField(
        maxLines: 5,
        decoration: InputDecoration(
          hintText: 'Write your review here...',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
