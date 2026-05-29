class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final int reviews;
  final int experienceYears;
  final String about;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    required this.experienceYears,
    required this.about,
  });
}

class Appointment {
  final String id;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorImageUrl;
  final DateTime dateTime;
  final String status; // 'Upcoming', 'Completed', 'Cancelled'
  final int documentsCount;

  Appointment({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImageUrl,
    required this.dateTime,
    required this.status,
    this.documentsCount = 0,
  });
}

class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String senderImageUrl;
  final String text;
  final DateTime timestamp;
  final bool isMe;
  final int unreadCount;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderImageUrl,
    required this.text,
    required this.timestamp,
    this.isMe = false,
    this.unreadCount = 0,
  });
}

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final String type; // 'appointment', 'message', 'system'
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });
}

class User {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final int appointmentsCount;
  final int doctorsCount;
  final int reviewsCount;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.appointmentsCount,
    required this.doctorsCount,
    required this.reviewsCount,
  });
}
