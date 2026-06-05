import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mediconnect/features/onboarding/screens/splash_screen.dart';
import 'package:mediconnect/features/onboarding/screens/onboarding_screen.dart';
import 'package:mediconnect/features/auth/screens/auth_screen.dart';
import 'package:mediconnect/features/auth/screens/login_screen.dart';
import 'package:mediconnect/features/auth/screens/register_screen.dart';
import 'package:mediconnect/features/auth/screens/forgot_password_screen.dart';
import 'package:mediconnect/features/auth/screens/profile_setup_screen.dart';
import 'package:mediconnect/features/home/screens/home_screen.dart';
import 'package:mediconnect/features/home/screens/sos_screen.dart';
import 'package:mediconnect/features/home/screens/notifications_screen.dart';
import 'package:mediconnect/features/home/screens/hospitals_screen.dart';
import 'package:mediconnect/features/doctor/screens/doctor_dashboard_screen.dart';
import 'package:mediconnect/features/doctor/screens/doctor_search_screen.dart';
import 'package:mediconnect/features/doctor/screens/doctor_profile_screen.dart';
import 'package:mediconnect/features/doctor/screens/booking_screen.dart';
import 'package:mediconnect/features/doctor/screens/video_call_screen.dart';
import 'package:mediconnect/features/doctor/screens/patient_list_screen.dart';
import 'package:mediconnect/features/doctor/screens/manage_schedule_screen.dart';
import 'package:mediconnect/features/doctor/screens/write_prescription_screen.dart';
import 'package:mediconnect/features/doctor/screens/doctor_earnings_screen.dart';
import 'package:mediconnect/features/appointments/screens/appointments_screen.dart';
import 'package:mediconnect/features/appointments/screens/appointment_details_screen.dart';
import 'package:mediconnect/features/appointments/screens/write_review_screen.dart';
import 'package:mediconnect/features/messages/presentation/screens/messages_screen.dart';
import 'package:mediconnect/features/messages/presentation/screens/message_thread_screen.dart';
import 'package:mediconnect/features/appointments/screens/reminders_screen.dart';
import 'package:mediconnect/features/health/screens/health_dashboard_screen.dart';
import 'package:mediconnect/features/health/screens/medication_tracker_screen.dart';
import 'package:mediconnect/features/health/screens/vital_detail_screen.dart';
import 'package:mediconnect/features/health/screens/medical_records_screen.dart';
import 'package:mediconnect/features/health/screens/prescriptions_screen.dart';
import 'package:mediconnect/features/profile/screens/profile_screen.dart';
import 'package:mediconnect/features/profile/screens/edit_profile_screen.dart';
import 'package:mediconnect/features/profile/screens/payments_screen.dart';
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
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const AuthGatewayScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/profile-setup',
      name: 'profile-setup',
      builder: (context, state) => const ProfileSetupScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ShellScreen(child: child),
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/doctors',
          name: 'doctors',
          builder: (context, state) => const DoctorSearchScreen(),
        ),
        GoRoute(
          path: '/appointments',
          name: 'appointments',
          builder: (context, state) => const AppointmentsListScreen(),
        ),
        GoRoute(
          path: '/health',
          name: 'health',
          builder: (context, state) => const HealthDashboardScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const UserProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/messages',
      name: 'messages',
      builder: (context, state) => const MessagesScreen(),
    ),
    GoRoute(
      path: '/messages/:id',
      name: 'message-thread',
      builder: (context, state) => MessageThreadScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/sos',
      name: 'sos',
      builder: (context, state) => const SOSScreen(),
    ),
    GoRoute(
      path: '/notifications',
      name: 'notifications',
      builder: (context, state) => const NotificationsCenterScreen(),
    ),
    GoRoute(
      path: '/doctor/home',
      name: 'doctor-home',
      builder: (context, state) => const DoctorDashboardScreen(),
    ),
    GoRoute(
      path: '/doctor/patients',
      name: 'doctor-patients',
      builder: (context, state) => const PatientListScreen(),
    ),
    GoRoute(
      path: '/doctor/schedule',
      name: 'doctor-schedule',
      builder: (context, state) => const ManageScheduleScreen(),
    ),
    GoRoute(
      path: '/doctor/prescription/new/:id',
      name: 'doctor-prescription-new',
      builder: (context, state) => WritePrescriptionScreen(appointmentId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/doctor/earnings',
      name: 'doctor-earnings',
      builder: (context, state) => const DoctorEarningsScreen(),
    ),
    GoRoute(
      path: '/doctor/:id',
      name: 'doctor-profile',
      builder: (context, state) => DoctorProfileScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/booking/:id',
      name: 'booking',
      builder: (context, state) => BookingFlowScreen(doctorId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/video-call',
      name: 'video-call',
      builder: (context, state) => const VideoCallScreen(),
    ),
    GoRoute(
      path: '/appointment/:id',
      name: 'appointment-detail',
      builder: (context, state) => AppointmentDetailsScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/appointment/:id/review',
      name: 'appointment-review',
      builder: (context, state) => WriteReviewScreen(appointmentId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/reminders',
      name: 'reminders',
      builder: (context, state) => const RemindersSettingsScreen(),
    ),
    GoRoute(
      path: '/vital-detail/:type',
      name: 'vital-detail',
      builder: (context, state) => VitalDetailView(type: state.pathParameters['type']!),
    ),
    GoRoute(
      path: '/medical-records',
      name: 'medical-records',
      builder: (context, state) => const MedicalRecordsScreen(),
    ),
    GoRoute(
      path: '/prescriptions',
      name: 'prescriptions',
      builder: (context, state) => const PrescriptionManagementScreen(),
    ),
    GoRoute(
      path: '/medications',
      name: 'medications',
      builder: (context, state) => const MedicationTrackerScreen(),
    ),
    GoRoute(
      path: '/hospitals',
      name: 'hospitals',
      builder: (context, state) => const NearbyHospitalsScreen(),
    ),
    GoRoute(
      path: '/payments',
      name: 'payments',
      builder: (context, state) => const PaymentsBillingScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/profile/edit',
      name: 'profile-edit',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/privacy',
      name: 'privacy',
      builder: (context, state) => const PrivacySecurityScreen(),
    ),
    GoRoute(
      path: '/support',
      name: 'support',
      builder: (context, state) => const HelpSupportScreen(),
    ),
    GoRoute(
      path: '/ai-chat',
      name: 'ai-chat',
      builder: (context, state) => const AIChatScreen(),
    ),
    GoRoute(
      path: '/symptom-checker',
      name: 'symptom-checker',
      builder: (context, state) => const SymptomCheckerScreen(),
    ),
  ],
);
