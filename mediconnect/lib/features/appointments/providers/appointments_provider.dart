import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/appointment.dart';

class AppointmentsNotifier extends StateNotifier<List<Appointment>> {
  AppointmentsNotifier() : super([
    Appointment(
      id: '1',
      doctorName: 'Dr. Marcus Horizon',
      specialty: 'Cardiologist',
      dateTime: DateTime.now().add(const Duration(hours: 2)),
      type: 'Telemedicine',
      status: 'Confirmed',
    ),
  ]);

  void addAppointment(Appointment appointment) {
    state = [...state, appointment];
  }

  void cancelAppointment(String id) {
    state = state.map((a) => a.id == id ? Appointment(
      id: a.id,
      doctorName: a.doctorName,
      specialty: a.specialty,
      dateTime: a.dateTime,
      type: a.type,
      status: 'Cancelled',
    ) : a).toList();
  }
}

final appointmentsProvider = StateNotifierProvider<AppointmentsNotifier, List<Appointment>>((ref) {
  return AppointmentsNotifier();
});
