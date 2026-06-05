import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_models.dart';
import '../services/mock_data_service.dart';

final doctorsProvider = Provider<List<Doctor>>((ref) {
  return MockDataService.doctors;
});

final appointmentsProvider = StateProvider<List<Appointment>>((ref) {
  return MockDataService.appointments;
});

final messagesProvider = StateProvider<List<Message>>((ref) {
  return MockDataService.messages;
});

final notificationsProvider = StateProvider<List<NotificationModel>>((ref) {
  return MockDataService.notifications;
});

final userProvider = Provider<User>((ref) {
  return MockDataService.currentUser;
});
