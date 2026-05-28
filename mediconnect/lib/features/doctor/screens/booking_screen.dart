import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';

class BookingFlowScreen extends StatefulWidget {
  final String doctorId;
  const BookingFlowScreen({super.key, required this.doctorId});

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  int _currentStep = 0;
  String _selectedSlot = '';
  final List<String> _slots = ['09:00 AM', '10:30 AM', '01:00 PM', '02:30 PM', '04:00 PM'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: Column(
        children: [
          _buildStepProgress(),
          Expanded(child: _buildStepContent()),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildStepProgress() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          final isActive = _currentStep >= index;
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
                if (index < 2)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: _currentStep > index ? AppColors.primary : Colors.grey[300],
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildDateTimeStep();
      case 1:
        return _buildConsultationTypeStep();
      case 2:
        return _buildPaymentStep();
      default:
        return Container();
    }
  }

  Widget _buildDateTimeStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 15),
          CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)),
            onDateChanged: (date) {},
          ),
          const SizedBox(height: 30),
          const Text('Select Time Slot', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _slots.map((slot) {
              final isSelected = _selectedSlot == slot;
              return GestureDetector(
                onTap: () => setState(() => _selectedSlot = slot),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isSelected ? AppColors.primary : Colors.grey[300]!),
                  ),
                  child: Text(slot, style: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildConsultationTypeStep() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Consultation Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          _buildTypeCard('In-Clinic', 'Visit the doctor at the clinic', Icons.home_work_outlined, true),
          const SizedBox(height: 20),
          _buildTypeCard('Telemedicine', 'Video call with the doctor', Icons.video_camera_front_outlined, false),
        ],
      ),
    );
  }

  Widget _buildTypeCard(String title, String subtitle, IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? AppColors.primary : Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isSelected ? AppColors.primary : Colors.grey[100], borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: isSelected ? Colors.white : AppColors.textSecondary),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              ],
            ),
          ),
          if (isSelected) const Icon(Icons.check_circle, color: AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildPaymentStep() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: const Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Consultation Fee'), Text('\$50.00')]),
                SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Service Fee'), Text('\$2.00')]),
                Divider(height: 30),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Total', style: TextStyle(fontWeight: FontWeight.bold)), Text('\$52.00', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary))]),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: const Row(
              children: [
                Icon(Icons.credit_card, color: AppColors.primary),
                SizedBox(width: 15),
                Text('**** **** **** 4242'),
                Spacer(),
                Icon(Icons.expand_more),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _currentStep--),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Back'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 15),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep < 2) {
                  setState(() => _currentStep++);
                } else {
                  _showSuccessDialog();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(0, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(_currentStep == 2 ? 'Confirm & Pay' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: AppColors.secondary, size: 80),
            const SizedBox(height: 20),
            const Text('Booking Successful!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 10),
            const Text('Your appointment has been booked. You will receive a confirmation message.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
