import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile {
  final String name;
  final String id;
  final String dob;
  final String bloodType;
  final String imageUrl;

  UserProfile({
    required this.name,
    required this.id,
    required this.dob,
    required this.bloodType,
    required this.imageUrl,
  });
}

class UserNotifier extends StateNotifier<UserProfile> {
  UserNotifier() : super(UserProfile(
    name: 'Sarah Adams',
    id: 'MC-2023-8942',
    dob: '12/05/1995',
    bloodType: 'A+',
    imageUrl: 'https://i.pravatar.cc/150?u=user',
  ));

  void updateName(String name) {
    state = UserProfile(
      name: name,
      id: state.id,
      dob: state.dob,
      bloodType: state.bloodType,
      imageUrl: state.imageUrl,
    );
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserProfile>((ref) {
  return UserNotifier();
});
