import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:only_us/models/message.dart';

class SocketService {
  WebSocket? _socket;
  StreamController<Message> _messageController =
      StreamController<Message>.broadcast();

  Stream<Message> get messages => _messageController.stream;

  bool get isConnected => _socket != null;

  Future<void> connect(String url) async {
    try {
      print("Connecting to $url ...");

      _socket = await WebSocket.connect(url);

      print("✅ Connected to server");

      _socket!.listen(
        (data) {
          print("📩 Raw Received: $data");

          try {
            final decoded = jsonDecode(data);
            final message = Message.fromJson(decoded);

            _messageController.add(message);
          } catch (e) {
            print("❌ JSON Parse Error: $e");
          }
        },
        onError: (error) {
          print("❌ Socket Error: $error");
          _reconnect(url);
        },
        onDone: () {
          print("🔌 Connection closed");
          _reconnect(url);
        },
        cancelOnError: true,
      );
    } catch (e) {
      print("❌ Connection failed: $e");
      _reconnect(url);
    }
  }

  void sendMessage(Message message) {
    if (_socket != null && _socket!.readyState == WebSocket.open) {
      final data = jsonEncode(message.toJson());
      print("📤 Sending: $data");
      _socket!.add(data);
    } else {
      print("❌ Cannot send, socket not connected");
    }
  }

  void disconnect() {
    print("🔌 Disconnecting...");
    _socket?.close();
    _socket = null;
  }

  void _reconnect(String url) {
    print("🔁 Reconnecting in 3 seconds...");
    Future.delayed(Duration(seconds: 3), () {
      connect(url);
    });
  }

  void dispose() {
    _messageController.close();
    disconnect();
  }
}
