import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/core/theme/app_theme.dart';
import 'package:animate_do/animate_do.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Setup'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: _buildStepContent(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep < 2) {
                  setState(() => _currentStep++);
                } else {
                  context.go('/home');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(_currentStep == 2 ? 'Finish' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: _currentStep >= index ? AppColors.primary : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: _currentStep >= index ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (index < 2)
                Container(
                  width: 40,
                  height: 2,
                  color: _currentStep > index ? AppColors.primary : Colors.grey[300],
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return FadeIn(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.background,
                child: Icon(Icons.camera_alt, size: 40, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 40),
              _buildTextField('Full Name', Icons.person_outline),
              const SizedBox(height: 20),
              _buildTextField('Date of Birth', Icons.calendar_today_outlined),
              const SizedBox(height: 20),
              _buildTextField('Gender', Icons.male_outlined),
            ],
          ),
        );
      case 1:
        return FadeIn(
          child: Column(
            children: [
              _buildTextField('Weight (kg)', Icons.monitor_weight_outlined),
              const SizedBox(height: 20),
              _buildTextField('Height (cm)', Icons.height),
              const SizedBox(height: 20),
              _buildTextField('Blood Type', Icons.bloodtype_outlined),
              const SizedBox(height: 20),
              _buildTextField('Allergies', Icons.warning_amber_outlined),
            ],
          ),
        );
      case 2:
        return FadeIn(
          child: Column(
            children: [
              const Text(
                'Almost there!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose your notification preferences and medical data sharing options.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 40),
              SwitchListTile(
                value: true,
                onChanged: (v) {},
                title: const Text('Push Notifications'),
                activeColor: AppColors.primary,
              ),
              SwitchListTile(
                value: true,
                onChanged: (v) {},
                title: const Text('Health Data Sync'),
                activeColor: AppColors.primary,
              ),
            ],
          ),
        );
      default:
        return Container();
    }
  }

  Widget _buildTextField(String label, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
