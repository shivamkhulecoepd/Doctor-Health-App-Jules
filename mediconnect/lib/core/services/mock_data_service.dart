import '../models/app_models.dart';

class MockDataService {
  static final User currentUser = User(
    id: 'u1',
    name: 'Sarah Adams',
    email: 'sarah.adams@example.com',
    imageUrl: 'https://i.pravatar.cc/150?u=sarah',
    appointmentsCount: 12,
    doctorsCount: 4,
    reviewsCount: 8,
  );

  static final List<Doctor> doctors = [
    Doctor(
      id: 'd1',
      name: 'Dr. Marcus Horizon',
      specialty: 'Cardiologist',
      imageUrl: 'https://i.pravatar.cc/150?u=d1',
      rating: 4.9,
      reviews: 120,
      experienceYears: 8,
      about: 'Dr. Marcus is an experienced cardiologist with a focus on heart rhythm management and preventive care.',
    ),
    Doctor(
      id: 'd2',
      name: 'Dr. Maria Elena',
      specialty: 'Psychologist',
      imageUrl: 'https://i.pravatar.cc/150?u=d2',
      rating: 4.8,
      reviews: 95,
      experienceYears: 10,
      about: 'Dr. Maria specializes in cognitive behavioral therapy and family counseling.',
    ),
    Doctor(
      id: 'd3',
      name: 'Dr. John Adams',
      specialty: 'Dermatologist',
      imageUrl: 'https://i.pravatar.cc/150?u=d3',
      rating: 4.7,
      reviews: 80,
      experienceYears: 6,
      about: 'Dr. John focuses on medical and cosmetic dermatology with a patient-centric approach.',
    ),
  ];

  static final List<Appointment> appointments = [
    Appointment(
      id: 'a1',
      doctorId: 'd1',
      doctorName: 'Dr. Marcus Horizon',
      doctorSpecialty: 'Cardiologist',
      doctorImageUrl: 'https://i.pravatar.cc/150?u=d1',
      dateTime: DateTime.now().add(const Duration(days: 2, hours: 2)),
      status: 'Upcoming',
      documentsCount: 2,
    ),
    Appointment(
      id: 'a2',
      doctorId: 'd2',
      doctorName: 'Dr. Maria Elena',
      doctorSpecialty: 'Psychologist',
      doctorImageUrl: 'https://i.pravatar.cc/150?u=d2',
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
      status: 'Completed',
      documentsCount: 1,
    ),
  ];

  static final List<Message> messages = [
    Message(
      id: 'm1',
      senderId: 'd1',
      senderName: 'Dr. Marcus Horizon',
      senderImageUrl: 'https://i.pravatar.cc/150?u=d1',
      text: 'Hello Sarah, how are you feeling today?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      unreadCount: 1,
    ),
    Message(
      id: 'm2',
      senderId: 'd2',
      senderName: 'Dr. Maria Elena',
      senderImageUrl: 'https://i.pravatar.cc/150?u=d2',
      text: 'The prescription has been updated.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      unreadCount: 0,
    ),
  ];

  static final List<NotificationModel> notifications = [
    NotificationModel(
      id: 'n1',
      title: 'Appointment Confirmed',
      body: 'Your appointment with Dr. Marcus is confirmed for Oct 24.',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      type: 'appointment',
    ),
    NotificationModel(
      id: 'n2',
      title: 'New Message',
      body: 'You have a new message from Dr. Maria.',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      type: 'message',
    ),
  ];
}
