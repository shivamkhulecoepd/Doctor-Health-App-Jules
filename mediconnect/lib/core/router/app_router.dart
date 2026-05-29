import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/features/onboarding/screens/splash_screen.dart';
import 'package:mediconnect/features/onboarding/screens/onboarding_screen.dart';
import 'package:mediconnect/features/auth/screens/auth_screen.dart';
import 'package:mediconnect/features/auth/screens/profile_setup_screen.dart';
import 'package:mediconnect/features/home/screens/home_screen.dart';
import 'package:mediconnect/features/home/screens/sos_screen.dart';
import 'package:mediconnect/features/home/screens/notifications_screen.dart';
import 'package:mediconnect/features/doctor/screens/doctor_search_screen.dart';
import 'package:mediconnect/features/doctor/screens/doctor_profile_screen.dart';
import 'package:mediconnect/features/doctor/screens/booking_screen.dart';
import 'package:mediconnect/features/doctor/screens/video_call_screen.dart';
import 'package:mediconnect/features/appointments/screens/appointments_screen.dart';
import 'package:mediconnect/features/appointments/screens/appointment_details_screen.dart';
import 'package:mediconnect/features/appointments/screens/reminders_screen.dart';
import 'package:mediconnect/features/health/screens/health_dashboard_screen.dart';
import 'package:mediconnect/features/health/screens/vital_detail_screen.dart';
import 'package:mediconnect/features/health/screens/medical_records_screen.dart';
import 'package:mediconnect/features/health/screens/prescriptions_screen.dart';
import 'package:mediconnect/features/profile/screens/profile_screen.dart';
import 'package:mediconnect/features/profile/screens/settings_screen.dart';
import 'package:mediconnect/features/profile/screens/privacy_screen.dart';
import 'package:mediconnect/features/profile/screens/support_screen.dart';
import 'package:mediconnect/features/ai_assistant/screens/ai_chat_screen.dart';
import 'package:mediconnect/features/health/screens/symptom_checker_screen.dart';
import 'package:mediconnect/features/common/screens/shell_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthGatewayScreen(),
    ),
    GoRoute(
      path: '/profile-setup',
      builder: (context, state) => const ProfileSetupScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ShellScreen(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/doctors',
          builder: (context, state) => const DoctorSearchScreen(),
        ),
        GoRoute(
          path: '/appointments',
          builder: (context, state) => const AppointmentsListScreen(),
        ),
        GoRoute(
          path: '/health',
          builder: (context, state) => const HealthDashboardScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const UserProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/sos',
      builder: (context, state) => const SOSScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsCenterScreen(),
    ),
    GoRoute(
      path: '/doctor/:id',
      builder: (context, state) => DoctorProfileScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/booking/:id',
      builder: (context, state) => BookingFlowScreen(doctorId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/video-call',
      builder: (context, state) => const VideoCallScreen(),
    ),
    GoRoute(
      path: '/appointment/:id',
      builder: (context, state) => AppointmentDetailsScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/reminders',
      builder: (context, state) => const RemindersSettingsScreen(),
    ),
    GoRoute(
      path: '/vital-detail/:type',
      builder: (context, state) => VitalDetailView(type: state.pathParameters['type']!),
    ),
    GoRoute(
      path: '/medical-records',
      builder: (context, state) => const MedicalRecordsScreen(),
    ),
    GoRoute(
      path: '/prescriptions',
      builder: (context, state) => const PrescriptionManagementScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/privacy',
      builder: (context, state) => const PrivacySecurityScreen(),
    ),
    GoRoute(
      path: '/support',
      builder: (context, state) => const HelpSupportScreen(),
    ),
    GoRoute(
      path: '/ai-chat',
      builder: (context, state) => const AIChatScreen(),
    ),
    GoRoute(
      path: '/symptom-checker',
      builder: (context, state) => const SymptomCheckerScreen(),
    ),
  ],
);
