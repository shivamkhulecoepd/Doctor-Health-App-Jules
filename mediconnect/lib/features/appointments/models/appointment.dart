class Appointment {
  final String id;
  final String doctorName;
  final String specialty;
  final DateTime dateTime;
  final String type; // 'In-Clinic' or 'Telemedicine'
  final String status; // 'Confirmed', 'Pending', 'Cancelled'

  Appointment({
    required this.id,
    required this.doctorName,
    required this.specialty,
    required this.dateTime,
    required this.type,
    required this.status,
  });
}
