import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final socketProvider = StreamProvider.autoDispose<dynamic>((ref) {
  // Mock socket URL
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );

  ref.onDispose(() => channel.sink.close());

  return channel.stream;
});

final vitalStreamProvider = Provider.autoDispose<AsyncValue<dynamic>>((ref) {
  return ref.watch(socketProvider);
});
