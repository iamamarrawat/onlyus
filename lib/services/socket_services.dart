import 'dart:convert';
import 'dart:io';

import 'package:only_us/models/message.dart';

class SocketService {
  WebSocket? _socket;

  Function(Message)? onMessageReceived;

  Future<void> connect(String url) async {
    _socket = await WebSocket.connect(url);
    print("Connected to server");

    _socket!.listen((data) {
      final decoded = jsonDecode(data);
      final message = Message.fromJson(decoded);

      if (onMessageReceived != null) {
        onMessageReceived!(message);
      }
    });
  }

  void sendMessage(Message message) {
    if (_socket != null) {
      _socket!.add(jsonEncode(message.toJson()));
    }
  }

  void disconnect() {
    _socket?.close();
  }
}
