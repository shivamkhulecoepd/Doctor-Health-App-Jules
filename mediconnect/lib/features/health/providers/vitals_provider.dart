import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vital.dart';

class VitalsNotifier extends StateNotifier<Map<String, Vital>> {
  VitalsNotifier() : super({
    'Heart Rate': Vital(type: 'Heart Rate', value: '82', unit: 'bpm', timestamp: DateTime.now()),
    'Sleep': Vital(type: 'Sleep', value: '7.3', unit: 'h', timestamp: DateTime.now()),
    'Steps': Vital(type: 'Steps', value: '8432', unit: '', timestamp: DateTime.now()),
  });

  void updateVital(String type, String value) {
    state = {
      ...state,
      type: Vital(
        type: type,
        value: value,
        unit: state[type]?.unit ?? '',
        timestamp: DateTime.now(),
      ),
    };
  }
}

final vitalsProvider = StateNotifierProvider<VitalsNotifier, Map<String, Vital>>((ref) {
  return VitalsNotifier();
});
